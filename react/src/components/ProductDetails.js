import React from 'react';
import StarRatingComponent from 'react-star-rating-component';

const ProductDetails = props => {
  let productImage;
  if (props.product.product_photo) {
    productImage = <img className="product" size="400px" src={props.product.product_photo}/>
  }

  let productSize;
  if (props.product.size) {
    productSize = <p>Size: {props.product.size} oz</p>
  }

  let productPrice;
  if (props.product.price) {
    productPrice = <p>Price: {props.product.price}</p>
  }

  let productColor;
  if (props.product.color) {
    productColor = <p>Color: {props.product.color}</p>
  }

  let productDescription;
  if (props.product.description) {
    productDescription = <p><h4>Description:</h4>{props.product.description}</p>
  }

  return (
    <table>
      <tbody>
        <tr>
          <td className="product image">{productImage}</td>
          <td className="product description">
            <h3>{props.product.brand}</h3>
            <h2 className="product-name">{props.product.name}</h2>
            <p>{productSize}</p>
            <p>{productPrice}</p>
            <p>{productColor}</p>
            <p>{productDescription}</p>
            <h4>Average Rating:</h4>
            <StarRatingComponent
              name='rating'
              editing={false}
              starCount={5}
              value={props.rating}
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
  )
}

export default ProductDetails;
