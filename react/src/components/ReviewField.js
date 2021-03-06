import React from 'react';

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
    </div>
  );
}

export default ReviewField;
