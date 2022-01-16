import React, { useCallback } from 'react';
import { useDispatch } from 'react-redux';
import { useHistory } from 'react-router-dom';
import { Button } from '@mui/material';

import Chessboard from '@app/lib/chessground';
import withLogin from '@app/hoc/withLogin';
import { unsetUser } from '@app/store/user';
import userApi from '@app/api/user';

function HomePage() {
  const history = useHistory();
  const dispatch = useDispatch();

  const handleLogout = useCallback(() => {
    userApi.logout();
    history.push('/');
    dispatch(unsetUser());
  }, [history, dispatch]);

  return (
    <div className="cor-container p-20" style={{ color: '#ffffff' }}>
      <h1>Chess on Rails</h1>
      <p>Stay tuned! This website is coming soon 😈</p>
      <p>Till then, here&apos;s a dummy board 😁</p>
      <Chessboard style={{ height: 400, width: 400 }} theme="purple" />
      <Button variant="contained" onClick={handleLogout}>
        Logout
      </Button>
    </div>
  );
}

export default withLogin(HomePage);
