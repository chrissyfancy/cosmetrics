import React from 'react';
import { IntlProvider, FormattedNumber } from 'react-intl';
import StarRatingComponent from 'react-star-rating-component';

const ProductDetails = props => {
  let productImage;
  if (props.product.product_photo) {
    productImage = <img className="product" size="400px" src={props.product.product_photo}/>
  }

  let productSize;
  if (props.product.size) {
    productSize = <p><strong>Size: </strong>{props.product.size} oz</p>
  }

  let productPrice;
  if (props.product.price) {
    productPrice =
    <p><strong>Price: </strong>
      <IntlProvider locale="en">
        <FormattedNumber value={props.product.price} style="currency" currency="USD"/>
      </IntlProvider>
    </p>
  }

  let productColor;
  if (props.product.color) {
    productColor = <p><strong>Color: </strong>{props.product.color}</p>
  }

  let productDescription;
  if (props.product.description) {
    productDescription =
    <div>
      <h4>Description:</h4>
      <p>{props.product.description}</p>
    </div>
  }

  return (
    <table>
      <tbody>
        <tr>
          <td className="product image">{productImage}</td>
          <td className="product description">
            <h3>{props.product.brand}</h3>
            <h2 className="product-name">{props.product.name}</h2>
            {productSize}
            {productPrice}
            {productColor}
            {productDescription}
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
