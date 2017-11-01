import React from 'react';
import StarRatingComponent from 'react-star-rating-component';

const BrandShow = props => {
  let brand = props.brand

  return (
    <div className="brand-show">
    {brand.title}
    </div>
  );
}

export default BrandShow;
