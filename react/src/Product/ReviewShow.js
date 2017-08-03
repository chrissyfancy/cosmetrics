import React from 'react';
import StarRatingComponent from 'react-star-rating-component';

const ReviewShow = props => {
  console.log(props.review.body)
  return (
    <div id="review">
      <h3>"Profile Photo for User"</h3>
      <p>{props.review.body}</p>
      <p> "Button for upvotes and downvotes if user is signed in & functionality" </p>
      <StarRatingComponent
        name='rating'
        editing={false}
        starCount={5}
        value={props.review.rating}
        starColor='#DE87B1'
        emptyStarColor='#333'
        renderStarIcon={(index, value) => {
          return <span className={index <= value ? 'fa fa-star' : 'fa fa-star-o'} />;
        }}
        renderStarIconHalf={() => <span className="fa fa-star-half-full" />}
      />
      <p>"Edit or delete functionality if user or admin"</p>
      <hr/>
    </div>
  );
}

export default ReviewShow;
