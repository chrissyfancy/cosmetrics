import React from 'react';
import RatingField from './../components/RatingField';
import ReviewField from './../components/ReviewField';
import StarRatingComponent from 'react-star-rating-component';

class ReviewFormContainer extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      errors: {},
      newReview: '',
      reviewRating: '',
      currentUser: '',
      productId: '',
     }
    this.addNewReview = this.addNewReview.bind(this);
    this.handleClearForm = this.handleClearForm.bind(this);
    this.handleFormSubmit = this.handleFormSubmit.bind(this);
    this.handleNewReview = this.handleNewReview.bind(this);
    this.onStarClickHalfStar = this.onStarClickHalfStar.bind(this);
    this.validateNewReview = this.validateNewReview.bind(this);
  }

  componentDidMount() {
    let rootDiv = document.getElementById("react-app")
    let productId = rootDiv.dataset.productId
    let currentUserId = rootDiv.dataset.currentUserId
    this.setState ({ currentUser: currentUserId, productId: productId })
  }

  addNewReview(review) {
    fetch(`/api/v1/products/${this.state.productId}/reviews`, {
      method: "POST",
      credentials: "same-origin",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify(review)
    })
    .then(response => {
      if (response.ok) {
        return response;
      } else {
        let errorMessage = `${response.status} (${response.statusText})`;
        let error = new Error(errorMessage);
        throw(error);
      }
    })
    .then(response => response.json())
    .then(responseData => { return responseData })
    .catch(error => console.error(`Error in fetch: ${error.message}`));
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
          user_id: this.state.currentUser,
          product_id: this.state.productId
        }
      };
      this.addNewReview(formPayload);
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

    let showReviewForm
    if (this.state.currentUser) {
      showReviewForm = "show"
    } else {
      showReviewForm = "hide"
    }

    return (
      <div className={showReviewForm}>
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
          <div className="button-group">
            <input className="button" type="submit" value="Submit" />
          </div>
        </form>
      </div>
    );
  }
}

export default ReviewFormContainer;
