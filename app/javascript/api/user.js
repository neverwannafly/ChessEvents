import apiRequest from '@app/lib/api';

const logout = () => {
  apiRequest('DELETE', '/api/sessions/1');
};

export default {
  logout,
};
