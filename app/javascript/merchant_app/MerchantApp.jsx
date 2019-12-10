import React, { Component, Fragment } from 'react';
import SignIn from './components/SignIn';
import { apiUrl } from './config';
import axios from 'axios';
import { BrowserRouter as Router, Switch, Route } from 'react-router-dom';
import Merchants from './containers/Merchants';
import Header from './components/Herader';

class MerchantApp extends Component {
  constructor(props) {
    super(props)
    this.state = {
      jwt: null,
      errorMessage: null
    }
  };

  authorize = (email, password) => {
    axios({
      method:'post',
      url:`${apiUrl}/auth/authorize`,
      data: { email, password },
      responseType:'json'
    }).then(res => {
      const { jwt } = res.data;
      this.setState({jwt, errorMessage: null});
    }).catch(error => {
      const errorMessage = error.response.data.error;
      this.setState({errorMessage});
    });
  };

  render() {
    const isAuthorized = this.state.jwt !== null;

    return(
      <Fragment>
        <Header />
        <Router>
          <div className='MerchantApp'>
            <Switch>
              <Route path='/signin' exact render={ () => (
                <SignIn
                  onSignInSubmit={this.authorize}
                  errorMessage={this.state.errorMessage}
                  isAuthorized={isAuthorized}/>
              )}/>

              <Route path='/' exact render={ () => (
                <Merchants
                  jwt={this.state.jwt}
                  isAuthorized={isAuthorized} />
              )}/>
            </Switch>
          </div>
        </Router>
      </Fragment>
    )
  };
};

export default MerchantApp;
