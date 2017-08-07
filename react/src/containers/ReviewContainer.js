import React from 'react';
import ReviewShow from './../components/ReviewShow';

class ReviewContainer extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      currentUser: '',
      productId: '',
      reviews: []
    }
    this.deleteReview = this.deleteReview.bind(this)
  }

  componentWillMount() {
    let rootDiv = document.getElementById("react-app")
    let productId = rootDiv.dataset.productId
    let currentUserId = rootDiv.dataset.currentUserId

    fetch(`/api/v1/products/${productId}/reviews`)
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
        this.setState ({
          currentUser: currentUserId,
          productId: productId,
          reviews: body.product_reviews
        });
      })
      .catch(error => console.error(`Error in fetch: ${error.message}`));
  }

  // deleteReview(review) {
  //   fetch(`/api/v1/products/${this.state.productId}/reviews/${review}`, {
  //     method: "DELETE"
  //   })
  //   .then(response => {
  //     if (response.ok) {
  //       return response;
  //     } else {
  //       let errorMessage = `${response.status} (${response.statusText})`,
  //           error = new Error(errorMessage);
  //       throw(error);
  //     }
  //   })
  //   .then(response => response.json())
  //   .catch(error => console.error(`Error in fetch: ${error.message}`));
  // }
  //
  render() {
    let showReviews;
    if (this.state.reviews.length > 0) {
      showReviews = this.state.reviews.map(review => {
        return(
          <ReviewShow
            key={review.review.id}
            review={review.review}
            reviewer={review.user}
            currentUser={this.state.currentUser}
            handleDelete={this.deleteReview}
          />
        )
      })
    } else {
      showReviews = <h4>There are currently no reviews for this product.</h4>
    }

    return (
      <div id="reviews">
        <h2 className="reviews">Reviews</h2>
        {showReviews}
      </div>
    );
  }
}

export default ReviewContainer;
