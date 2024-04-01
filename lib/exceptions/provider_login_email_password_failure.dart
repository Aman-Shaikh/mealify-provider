
class WLoginWithEmailAndPasswordFailure {
  final String message;

  const WLoginWithEmailAndPasswordFailure([this.message = "An Unknown error occurred."]);

  factory WLoginWithEmailAndPasswordFailure.fromCode(String code){
    switch (code) {
      case 'invalid-email':
        return const WLoginWithEmailAndPasswordFailure (
            'Email is not valid or badly formatted.');
      case 'user-not-found':
        return const WLoginWithEmailAndPasswordFailure (
            'There is no existing user record corresponding to the provided identifier.Signup please');
      case 'operation-not-allowed':
        return const WLoginWithEmailAndPasswordFailure (
            'The provided sign-in provider is disabled for your Firebase project. Enable it from the Sign-in Method section of the Firebase console.');
      case 'invalid-password':
        return const WLoginWithEmailAndPasswordFailure (
            'The provided value for the password user property is invalid. It must be a string with at least six characters.');
      case 'invalid-password-hash':
        return const WLoginWithEmailAndPasswordFailure(
            'The password hash must be a valid byte buffer.');
      case 'invalid-password-salt':
        return const WLoginWithEmailAndPasswordFailure(
            'The password salt must be a valid byte buffer');
      case 'invalid-credential':
        return const WLoginWithEmailAndPasswordFailure(
            'Please enter valid credentials.');

      default:
        return const WLoginWithEmailAndPasswordFailure('Please Enter Valid Credential');
    }
  }
}