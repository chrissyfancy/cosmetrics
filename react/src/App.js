import React from 'react';
import ProductContainer from './containers/ProductContainer'
import ReviewContainer from './containers/ReviewContainer'
import ReviewFormContainer from './containers/ReviewFormContainer'

const App = props => {
  return(
    <div>
      <ProductContainer />
      <ReviewContainer />
      <ReviewFormContainer />
    </div>
  )
}

export default App
