import React from 'react';
import StarRatingComponent from 'react-star-rating-component';
import ProductDetails from './../components/ProductDetails'

class ProductContainer extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      errors: {},
      product: '',
      rating: 0,
      productId: ''
    }
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
        this.setState({ product: body.product, rating: body.rating, productId: productId });
      })
      .catch(error => console.error(`Error in fetch: ${error.message}`));
  }

  render() {
    return(
      <div>
        <ProductDetails product={this.state.product} rating={this.state.rating} />
      </div>
    )
  }
}

export default ProductContainer;
