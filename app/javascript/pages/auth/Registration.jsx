import React, { useCallback, useState } from 'react';
import { useHistory } from 'react-router-dom';
import LoginIcon from '@mui/icons-material/Login';

import { EMAIL_REGEX } from '@app/constants/regex';

function RegistrationForm() {
  const history = useHistory();

  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [repeatPassword, setRepeatPassword] = useState('');
  const [formErrors, setFormErrors] = useState([]);

  const backToLogin = useCallback(() => {
    history.push('/auth/signin');
  }, [history]);

  const validateEmail = useCallback(() => {
    if (!EMAIL_REGEX.test(email)) return 'Wrong email';
    return null;
  }, []);

  const validatePassword = useCallback(() => {
    if (!password || password.length < 6) return 'Passwords must be more than 6 characters';
    return null;
  }, []);

  const validatePasswordConfirmation = useCallback(() => {
    !password || password !== repeatPassword ? 'Passwords dont match' : null;
  }, []);

  const registrationSubmitHandler = useCallback((event) => {
    event.preventDefault();

    const errors = [];
    const emailCheck = validateEmail();
    if (emailCheck) errors.push(emailCheck);

    const passwordCheck = validatePassword();
    if (passwordCheck) errors.push(passwordCheck);

    const repeatCheck = validatePasswordConfirmation();
    if (repeatCheck) errors.push(repeatCheck);

    setFormErrors(errors);
  }, []);

  return (
    <div className="auth-form">
        <div className="auth-form__header" style={{ display: 'flex', alignItems: 'center', fontWeight: 100, marginBottom: '25px' }}>
          <LoginIcon style={{ marginRight: '10px', fontSize: '1.3em', color: '#83afe0' }} />
          <span>Chess on Rails</span>
        </div>
        <h1 className={classes.cardHeader}>Sign Up</h1>
        <div className="auth-form__body">
          <form onSubmit={registrationSubmitHandler}>
              {formErrors.length ? <Alert title="Registration failed">
                {formErrors.map(err => <div>{err}</div>)}
              </Alert> : ''}

              <div>
                <Label>
                    <span>Email</span>
                    <Input value={email} onChange={(e) => setEmail(e.target.value)} />
                </Label>
              </div>

              <div>
                <Label>
                    <span>Password</span>
                    <Input type="password" value={password} onChange={(e) => setPassword(e.target.value)} />
                </Label>
              </div>

              <div>
                <Label>
                    <span>Repeat password</span>
                    <Input type="password" value={repeatPassword} onChange={(e) => setRepeatPassword(e.target.value)} />
                </Label>
              </div>

              <div style={{ marginTop: '10px' }}>
                <Button type="submit" fullWidth>Create account</Button>
                <Divider />
              </div>

          </form>
        </div>
        <Button fullWidth onClick={backToLogin} color="green" iconLeft={<FaArrowLeft />}>Back to log in</Button>
    </div>
  );
}

export default RegistrationForm;
