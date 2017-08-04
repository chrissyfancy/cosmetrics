import React from 'react';
import RatingField from './../components/RatingField';
import ReviewField from './../components/ReviewField';
import ReviewShow from './../components/ReviewShow';
import StarRatingComponent from 'react-star-rating-component';

class ReviewContainer extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      errors: {},
      newReview: '',
      reviewRating: '',
      currentUser: '',
    }
    this.handleClearForm = this.handleClearForm.bind(this);
    this.handleFormSubmit = this.handleFormSubmit.bind(this);
    this.handleNewReview = this.handleNewReview.bind(this);
    this.onStarClickHalfStar = this.onStarClickHalfStar.bind(this);
    this.validateNewReview = this.validateNewReview.bind(this);
  }

  componentDidMount() {
    let rootDiv = document.getElementById("react-app")
    let currentUserId = rootDiv.dataset.currentUserId
    this.setState({ currentUser: currentUserId });
  }

  handleNewReview(event) {
    this.validateNewReview(event.target.value)
    this.setState({ newReview: event.target.value })
  }

  handleFormSubmit(event) {
    event.preventDefault();
    if (this.validateNewReview(this.state.newReview)) {
      let formPayload = {
        review: {
          body: this.state.newReview,
          rating: this.state.reviewRating,
          user_id: this.state.currentUser
        }
      };
      this.props.addNewReview(formPayload);
      this.handleClearForm(event);
    }
  }

  validateNewReview(review) {
    if (review === '') {
      let newError = { review: 'Review may not be blank.' }
      this.setState({ errors: Object.assign(this.state.errors, newError) })
      return false
    } else {
      let errorState = this.state.errors
      delete errorState.review
      this.setState({ errors: errorState })
      return true
    }
  }

  handleClearForm(event) {
    event.preventDefault();
    this.setState({
      errors: {},
      newReview: '',
      reviewRating: ''
    })
  }

  onStarClickHalfStar(nextValue, prevValue, name) {
    this.setState({ reviewRating: nextValue });
  }

  render() {
    let errorDiv;
    let errorItems;
    if (Object.keys(this.state.errors).length > 0) {
      errorItems = Object.values(this.state.errors).map(error => {
        return(<li key={error}>{error}</li>)
      })
      errorDiv = <div className="callout alert">{errorItems}</div>
    }

    let showReviews;
    if (this.props.reviews.length > 0) {
      showReviews = this.props.reviews.map(review => {
        return(
          <ReviewShow
            key={review.review.id}
            review={review.review}
            reviewer={review.user}
            currentUser={this.state.currentUser}
          />
        )
      })
    } else {
      showReviews = <h4>There are currently no reviews for this product.</h4>
    }

    return (
      <div>
        <div id="reviews">
          <h2 className="reviews">Reviews</h2>
          {showReviews}
        </div>
        <form className="callout" onSubmit={this.handleFormSubmit}>
          {errorDiv}
          <ReviewField
            content={this.state.reviews}
            handlerFunction={this.handleNewReview}
          />
          <RatingField
            onStarClick={this.onStarClickHalfStar}
            value={this.state.rating_half_star}
            onStarClick={this.onStarClickHalfStar}
          />
          <div className="button-group">
            <input className="button" type="submit" value="Submit" />
          </div>
        </form>
      </div>
    );
  }
}

export default ReviewContainer;
