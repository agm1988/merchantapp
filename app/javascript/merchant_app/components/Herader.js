import React from 'react';
import {
  AppBar,
  Toolbar,
  Typography,
} from '@material-ui/core';
import Button from '@material-ui/core/Button';

const Header = (props) => (
  <AppBar position="static">
    <Toolbar>
      <Typography variant="h6" color="inherit">
        Merchant App |
      </Typography>
      {props.isAuthorized && <Button
        onClick={props.onLogout}
        color="secondary"
        variant="contained"
        size="small">
        Logout
      </Button> }
    </Toolbar>
  </AppBar>
);

export default Header;
