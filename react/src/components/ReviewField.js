import React from 'react';
import ProductLifespanField from './ProductLifespanField'

const ReviewField = props => {
  return (
    <div>
      <label className="new-review">New Review</label>
      <input
        name='review'
        onChange={props.handlerFunction}
        type='text'
        value={props.content}
        />
      <ProductLifespanField
        handlerFunction={props.handlerFunction}
      />
    </div>
  );
}

export default ReviewField;
