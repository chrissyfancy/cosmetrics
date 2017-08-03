import React from 'react';
import ReviewField from './ReviewField';
import ReviewShow from './ReviewShow';
import StarRatingComponent from 'react-star-rating-component';

class ReviewContainer extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      errors: {},
      newReview: '',
      reviewRating: '',
      currentUser: ''
    }
    this.handleClearForm = this.handleClearForm.bind(this);
    this.handleFormSubmit = this.handleFormSubmit.bind(this);
    this.handleNewReview = this.handleNewReview.bind(this);
    this.onStarClickHalfStar = this.onStarClickHalfStar.bind(this);
    this.validateNewReview = this.validateNewReview.bind(this);
    this.getUserInfo = this.getUserInfo.bind(this);
  }

  componentDidMount() {
    let rootDiv = document.getElementById("react-app")
    let currentUserId = rootDiv.dataset.currentUserId
    this.setState({ currentUser: currentUserId });
  }

  handleClearForm(event) {
    event.preventDefault();
    this.setState({
      errors: {},
      newReview: '',
      reviewRating: ''
    })
  }

  handleFormSubmit(event) {
    event.preventDefault();
    if (
      this.validateNewReview(this.state.newReview)
    ) {
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

  handleNewReview(event) {
    this.validateNewReview(event.target.value)
    this.setState({ newReview: event.target.value })
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

  onStarClickHalfStar(nextValue, prevValue, name) {
    this.setState({ reviewRating: nextValue });
  }

  getUserInfo(userId) {
    fetch(`/api/v1/users/${userId}`)
      .then(response => {
        if (response.ok) {
          return response;
        } else {
          let errorMessage = `${response.status} (${response.statusText})`,
              error = new Error(errorMessage);
          throw(error);
        }
      })
      .then(response => response.json())
      .then(body => {
        return body
      })
      .catch(error => console.error(`Error in fetch: ${error.message}`));
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

    let allReviews = this.props.reviews.map(review => {
      let user = this.getUserInfo(review.user_id)
      return(
        <ReviewShow
          key={review.id}
          review={review}
          reviewer={user}
        />
      )
    })

    return (
      <div>
        <h2>Reviews</h2>
          {allReviews}
        <form className="callout" onSubmit={this.handleFormSubmit}>
          {errorDiv}
          <ReviewField
            content={this.state.reviews}
            label='New Review'
            name='review'
            handlerFunction={this.handleNewReview}
          />
          <h3>Rating</h3>
          <StarRatingComponent
            name="new-review-rating"
            value={this.state.rating_half_star}
            onStarClick={this.onStarClickHalfStar}
            renderStarIcon={(index, value) => {
              return <span className={index <= value ? 'fa fa-star' : 'fa fa-star-o'} />;
            }}
            renderStarIconHalf={() => <span className="fa fa-star-half-full" />}
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
