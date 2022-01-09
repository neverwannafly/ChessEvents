import React, { useCallback } from 'react';
import { EMAIL_REGEX } from '../../constants/regex';

function LoginForm() {
  const history = useHistory();

  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [formErrors, setFormErrors] = useState([]);

  const redirectToRegistration = useCallback(() => {
    history.push('/auth/signup');
  }, []);

  const validateEmail = useCallback(() => {
    if (!EMAIL_REGEX.test(email)) return 'Wrong email';
    return null;
  });

  const validatePassword = useCallback(() => {
    if (!password || password.length < 6) return 'Password must be more than 6 characters';
    return null;
  }, []);

  const loginSubmitHandler = useCallback((event) => {
    event.preventDefault();

    let errors = [];
    let emailCheck = validateEmail();
    if (emailCheck) {
      errors.push(emailCheck)
    };

    let passwordCheck = validatePassword();
    if (passwordCheck) {
      errors.push(passwordCheck)
    };

    setFormErrors(errors);
  }, []);

  return (
    <div className={classes.loginCard}>

     <div style={{ display: 'flex', alignItems: 'center', fontWeight: 100, marginBottom: '25px' }}>
        <FaChessBishop style={{ marginRight: '10px', fontSize: '1.3em', color: '#83afe0' }} />
        <span>Amazing service</span>
     </div>

     <h1 className={classes.cardHeader}>Log in</h1>

     <div className="form">

        <form onSubmit={loginSubmitHandler}>

           {formErrors.length ? <Alert title="Failed to login">
              {formErrors.map(err => <div>{err}</div>)}
           </Alert> : ''}

           {isSuccessed ? <Alert type="success">Welcome!</Alert> : ''}

           <div name="email" validate={emailValidate}>
              <Label>
                 <span>Email</span>
                 <Input value={email} onChange={(e) => setEmail(e.target.value)} />
              </Label>
           </div>

           <div name="password" validate={passwordValidate}>
              <Label>
                 <span>Password</span>
                 <Input type="password" value={password} onChange={(e) => setPassword(e.target.value)} />
              </Label>
           </div>

           <div style={{ marginTop: '10px' }}>
              <Button type="submit" fullWidth>Log in</Button>
           </div>

        </form>

     </div>

     <Divider />
     <Button fullWidth onClick={redirectToRegistration} color="green" iconLeft={<FaPlusCircle />}>Create account</Button>

  </div>
  );
}

export default LoginForm;