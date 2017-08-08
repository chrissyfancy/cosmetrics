import React from 'react';
import StarRatingComponent from 'react-star-rating-component';

const ReviewShow = props => {
  let profilePhoto;
  if (props.reviewer.profile_photo.url) {
    profilePhoto = <img className="review-profile-photo" src={props.reviewer.profile_photo.url} />
  }

  let options = {
    weekday: "long", year: "numeric", month: "short",
    day: "numeric", hour: "2-digit", minute: "2-digit"
  };
  let reviewTime = (new Date(props.review.updated_at).toLocaleTimeString("en-us", options));

  let deleteButton;
  if (props.currentUser == props.reviewer.id) {
    deleteButton = <input
      id={props.review.id}
      onClick={props.handleDelete}
      className="button"
      type="submit"
      value="Delete"
    />
  }

  return (
    <div className="review">
      {profilePhoto}
      <h4>{props.reviewer.first_name} {props.reviewer.last_name} left a review on {reviewTime}</h4>
      <p>{props.review.body}</p>
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
      {deleteButton}
      <hr/>
    </div>
  );
}

export default ReviewShow;
