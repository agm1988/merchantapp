import React, { Component } from 'react';
import { Redirect } from 'react-router-dom';
import Container from '@material-ui/core/Container';
import axios from "axios";
import {apiUrl} from "../config";
import {
  Typography,
  Paper,
} from '@material-ui/core';
import Merchant from './Merchant';
import Transactions from "../components/Transactions";

class Merchants extends Component {
  constructor(props) {
    super(props);
    this.state = {
      merchants: [],
      errorMessage: null,
      selectedMerchant: null,
    }
  };

  componentDidMount() {
    this.fetchMerchants();
  }

  fetchMerchants = () => {
    axios({
      method:'get',
      url:`${apiUrl}/merchants`,
      headers: { 'X-Access-Token': this.props.jwt },
      responseType:'json'
    }).then(res => {
      const merchants = res.data;
      this.setState({merchants});
    }).catch(error => {
      const errorMessage = error.response.data.error;
      this.setState({errorMessage});
    });
  };

  updateMerchant = (merchant) => {
    const dataToUpdate = (({ description, status, is_admin }) => ({ description, status, is_admin }))(merchant);

    axios({
      method:'put',
      url:`${apiUrl}/merchants/${merchant.id}`,
      data: { ...dataToUpdate },
      headers: { 'X-Access-Token': this.props.jwt },
      responseType:'json'
    }).then(res => {
      const merchant = res.data;
      const merchants = [...this.state.merchants];
      const idx = merchants.findIndex(m => m.id === merchant.id);
      merchants[idx] = merchant;
      this.setState({merchants, errorMessage: null});
    }).catch(error => {
      const errorMessage = error.response.data.error;
      this.setState({errorMessage});
    });
  };

  deleteMerchant = (merchantId) => {
    axios({
      method: 'delete',
      url: `${apiUrl}/merchants/${merchantId}`,
      headers: {'X-Access-Token': this.props.jwt},
      responseType: 'json'
    }).then(res => {
      const merchants = this.state.merchants.filter((merchant) => {
        return merchant.id !== merchantId;
      });

      this.setState({merchants});
    }).catch(error => {
      const errorMessage = error.response.data.error;
      this.setState({errorMessage});
    });
  };

  onOpenTransactionsDialog = (merchantId) => {
    const merchant = this.state.merchants.find((merchant => {
      return merchant.id === merchantId;
    }));

    this.setState({ selectedMerchant: merchant })
  };

  onCloseTransactionsDialog = () => {
    this.setState({selectedMerchant: null});
  }

  render() {
    if (!this.props.isAuthorized) {return (<Redirect to='/signin' />)};

    const noData = <Typography variant="subtitle1">No merchants to display</Typography>;
    const merchantsList = this.state.merchants.map(merchant => (
      <Merchant
        key={merchant.id}
        merchant={merchant}
        deleteMerchant={this.deleteMerchant}
        updateMerchant={this.updateMerchant}
        onOpenTransactionsDialog={this.onOpenTransactionsDialog} />
    ));

    return(
      <Container component="main" maxWidth="lg">
        { this.state.errorMessage &&
          <div className="error_message">{this.state.errorMessage}</div>
        }

        <Transactions
          merchant={this.state.selectedMerchant}
          onCloseTransactionsDialog={this.onCloseTransactionsDialog}/>

        <Typography variant="h4">Merchants</Typography>
        <Paper elevation={1} >
          {this.state.merchants.length > 0 ? (merchantsList) : noData}
        </Paper>
      </Container>
    )
  };
};

export default Merchants;
