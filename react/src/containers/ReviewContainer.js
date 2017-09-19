import React from 'react';
import ReactDOM from 'react-dom';
import RatingField from './../components/RatingField';
import ReviewField from './../components/ReviewField';
import WeeklyUsesField from './../components/WeeklyUsesField';
import MonthlyUsesField from './../components/MonthlyUsesField';
import ReviewShow from './../components/ReviewShow';
import StarRatingComponent from 'react-star-rating-component';

class ReviewContainer extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      errors: {},
      newReview: '',
      timesUsedPerWeek: '',
      monthsPerProduct: '',
      reviewRating: '',
      currentUser: ''
    }
    this.handleClearForm = this.handleClearForm.bind(this);
    this.handleFormSubmit = this.handleFormSubmit.bind(this);
    this.handleNewReview = this.handleNewReview.bind(this);
    this.handleNewWeeklyUses = this.handleNewWeeklyUses.bind(this);
    this.handleNewMonthlyUses = this.handleNewMonthlyUses.bind(this);
    this.handleScrollToReviews = this.handleScrollToReviews.bind(this);
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

  handleNewWeeklyUses(event) {
    this.setState({ timesUsedPerWeek: event.target.value })
  }

  handleNewMonthlyUses(event) {
    this.setState({ monthsPerProduct: event.target.value })
  }

  handleFormSubmit(event) {
    event.preventDefault();
    if (this.validateNewReview(this.state)) {
      let formPayload = {
        review: {
          body: this.state.newReview,
          rating: this.state.reviewRating,
          user_id: this.state.currentUser,
          times_used_per_week: this.state.timesUsedPerWeek,
          months_product_lasts: this.state.monthsPerProduct
        }
      };
      this.props.addNewReview(formPayload);
      this.handleClearForm();
      this.handleScrollToReviews();
    }
  }

  validateNewReview(review) {
    if (review.newReview === '') {
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

  handleScrollToReviews() {
    let reviewHeight = document.getElementById('reviews')
    window.scrollTo(reviewHeight.offsetTop, 0)
  }

  handleClearForm() {
    this.setState({
      errors: {},
      newReview: '',
      reviewRating: '',
      monthsPerProduct: '',
      timesUsedPerWeek: ''
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
            handleDelete={this.props.deleteReview}
          />
        )
      })
    } else {
      showReviews = <h4>There are currently no reviews for this product.</h4>
    }

    let showReviewForm
    if (this.state.currentUser !== '') {
      showReviewForm =
        <form className={showReviewForm} className="callout" onSubmit={this.handleFormSubmit}>
          {errorDiv}
          <ReviewField
            content={this.state.newReview}
            handlerFunction={this.handleNewReview}
          />
          <RatingField
            onStarClick={this.onStarClickHalfStar}
            value={this.state.rating_half_star}
            onStarClick={this.onStarClickHalfStar}
          />
          <WeeklyUsesField
            content={this.state.usesPerWeek}
            handlerFunction={this.handleNewWeeklyUses}
          />
          <MonthlyUsesField
            content={this.state.monthsPerProduct}
            handlerFunction={this.handleNewMonthlyUses}
          />
          <div className="button-group">
            <input className="button" type="submit" value="Submit" />
          </div>
        </form>
    }

    return (
      <div>
        <div id="reviews">
          <h2 className="reviews">Reviews</h2>
          {showReviews}
        </div>
        {showReviewForm}
      </div>
    );
  }
}

export default ReviewContainer;
