import React, { Component } from 'react';
import ExpansionPanel from '@material-ui/core/ExpansionPanel';
import ExpansionPanelDetails from '@material-ui/core/ExpansionPanelDetails';
import ExpansionPanelSummary from '@material-ui/core/ExpansionPanelSummary';
import ExpansionPanelActions from '@material-ui/core/ExpansionPanelActions';
import Typography from '@material-ui/core/Typography';
import ExpandMoreIcon from '@material-ui/icons/ExpandMore';
import Button from '@material-ui/core/Button';
import Divider from '@material-ui/core/Divider';
import TextField from "@material-ui/core/TextField";
import Grid from '@material-ui/core/Grid';
import Select from '@material-ui/core/Select';
import MenuItem from '@material-ui/core/MenuItem';

class Merchant extends Component {
  constructor(props) {
    super(props);

    this.state = {
      ...props.merchant,
    }
  }

  handleChange = (e) => {
    this.setState({ [e.target.name]: e.target.value })
  };

  updateMerchant = () => {
    this.props.updateMerchant(this.state);
  };

  deleteMerchant = () => {
    this.props.deleteMerchant(this.props.merchant.id);
  };

  onTransactionsClick = () => {
    this.props.onOpenTransactionsDialog(this.props.merchant.id);
  };

  render() {
    const descriptionBlank = this.state.description.trim() === '';

    return (
      <div>
        <ExpansionPanel>
          <ExpansionPanelSummary
            expandIcon={<ExpandMoreIcon/>}
            aria-controls="panel1c-content"
            id="panel1c-header"
          >
            <Grid container spacing={10}>
              <Grid item xs>
                <Typography variant='subtitle1'>{this.props.merchant.id}</Typography>
              </Grid>
              <Grid item xs>
                <Typography variant='subtitle1'>{this.props.merchant.email}</Typography>
              </Grid>
              <Grid item xs>
                <Typography variant='subtitle1'>{this.props.merchant.total_transaction_sum}</Typography>
              </Grid>
            </Grid>
          </ExpansionPanelSummary>
          <ExpansionPanelDetails>
            <Grid container spacing={2}>
              <Grid item xs>
                <TextField
                  id="description"
                  label="Multiline"
                  multiline
                  rows="4"
                  name="description"
                  value={this.state.description}
                  onChange={this.handleChange}
                  variant="outlined"
                  error={descriptionBlank}
                  helperText={descriptionBlank && "Should be present"}
                  required
                />
              </Grid>
              <Grid item xs>
                <Select
                  labelId="demo-simple-select-error-label"
                  id="status"
                  name='status'
                  value={this.state.status}
                  onChange={this.handleChange}>
                  <MenuItem value="">
                    <em>None</em>
                  </MenuItem>
                  <MenuItem value='active'>Active</MenuItem>
                  <MenuItem value='inactive'>Inactive</MenuItem>
                </Select>
              </Grid>
              <Grid item xs>
                <Select
                  labelId="is_admin"
                  id="is_admin"
                  name='is_admin'
                  value={this.state.is_admin}
                  onChange={this.handleChange}>
                  <MenuItem value='true'>Admin</MenuItem>
                  <MenuItem value='false'>Merchant</MenuItem>
                </Select>
              </Grid>
            </Grid>
          </ExpansionPanelDetails>
          <Divider/>
          <ExpansionPanelActions>
            <Button onClick={this.deleteMerchant} size="small" color="secondary">Delete</Button>
            <Button onClick={this.onTransactionsClick} variant="contained" size="small" color="primary">
              Transactions
            </Button>
            <Button size="small">Cancel</Button>
            <Button
              onClick={this.updateMerchant}
              disabled={descriptionBlank}
              size="small"
              color="primary">
                Update
            </Button>
          </ExpansionPanelActions>
        </ExpansionPanel>
        <Divider/>
      </div>
    )
  };
};

export default Merchant;
