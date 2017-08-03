import React from 'react';
import StarRatingComponent from 'react-star-rating-component';
import ReviewContainer from './ReviewContainer';

class ProductShowContainer extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      errors: {},
      product: '',
      reviews: [],
      rating: 0,
      productId: ''
    }
    this.addNewReview = this.addNewReview.bind(this);
  }

  componentDidMount() {
    let rootDiv = document.getElementById("react-app")
    let productId = rootDiv.dataset.productId
    let currentUserId = rootDiv.dataset.currentUserId

    fetch(`/api/v1/products/${productId}`)
      .then(response => {
        if (response.ok) {
          return response;
        } else {
          let errorMessage = `${response.status} (${response.statusText})`,
              error = new Error(errorMessage);
          throw(error);
        }
      })
      .then(response => response.json())
      .then(body => {
        this.setState({ product: body.product, reviews: body.reviews, rating: body.rating, productId: productId });
      })
      .catch(error => console.error(`Error in fetch: ${error.message}`));
  }

  addNewReview(review) {
    fetch(`/api/v1/products/${this.state.productId}/reviews`, {
      method: "POST",
      credentials: "same-origin",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify(review)
    })
    .then(response => {
      if (response.ok) {
        return response;
    } else {
        let errorMessage = `${response.status} (${response.statusText})`;
        let error = new Error(errorMessage);
        throw(error);
      }
      })
      .then(response => response.json())
      .then(responseData => {
        this.setState({ reviews: this.state.reviews.concat(responseData)})
      })
      .catch(error => console.error(`Error in fetch: ${error.message}`));
  }

  render() {
    let productImage;
    if (this.state.product.product_photo) {
      productImage = <img className="product" src={this.state.product.product_photo}/>
    }

    let productSize;
    if (this.state.product.size) {
      productSize = <p>Size: {this.state.product.size} oz</p>
    }

    let productPrice;
    if (this.state.product.price) {
      productPrice = <p>Price: {this.state.product.price}</p>
    }

    let productColor;
    if (this.state.product.color) {
      productColor = <p>Color: {this.state.product.color}</p>
    }

    let productDescription;
    if (this.state.product.description) {
      productDescription = <p><h4>What It Does:</h4>{this.state.product.description}</p>
    }

    return(
      <div>
        <table>
          <tbody>
            <tr>
              <td className="product image">{productImage}</td>
              <td className="product description">
                <h3>{this.state.product.brand}</h3>
                <h2 className="product-name">{this.state.product.name}</h2>
                <p>{productSize}</p>
                <p>{productPrice}</p>
                <p>{productColor}</p>
                <p>{productDescription}</p>
                <h4>Average Rating:</h4>
                <StarRatingComponent
                  name='rating'
                  editing={false}
                  starCount={5}
                  value={this.state.rating}
                  starColor='#DE87B1'
                  emptyStarColor='#333'
                  renderStarIcon={(index, value) => {
                    return <span className={index <= value ? 'fa fa-star' : 'fa fa-star-o'} />;
                  }}
                  renderStarIconHalf={() => <span className="fa fa-star-half-full" />}
                />
              </td>
            </tr>
          </tbody>
        </table>
        <ReviewContainer reviews={this.state.reviews} addNewReview={this.addNewReview} />
      </div>
    )
  }
}

export default ProductShowContainer
