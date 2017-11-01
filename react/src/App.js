import React from 'react';
import ProductContainer from './containers/ProductContainer'
import BrandContainer from './containers/BrandContainer'

const App = props => {
  return(
    <div>
      <BrandContainer />
      <ProductContainer />
    </div>
  )
}

export default App
