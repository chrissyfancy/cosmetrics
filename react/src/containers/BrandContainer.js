import React from 'react';
import BrandShow from './../components/BrandShow'

class BrandContainer extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      brands: []
    }
  }

  componentDidMount() {
    fetch(`https://api.birchbox.com/products/v2/brands`)
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
      this.setState({ brands: body });
    })
    .catch(error => console.error(`Error in fetch: ${error.message}`));
  }

  render() {
    let brands;
    if (this.state.brands.length > 0) {
      brands = this.state.brands.map(brand => {
        return(
          <BrandShow
            key={brand.id}
            brand={brand}
          />
        )
      })
    }

    return(
      <div>
      {brands}
      </div>
    )
  }
}

export default BrandContainer;
