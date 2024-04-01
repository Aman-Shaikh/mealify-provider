
class WSignUpWithEmailAndPasswordFailure {
  final String message;

  const WSignUpWithEmailAndPasswordFailure([this.message = "An Unknown error occurred."]);

  factory WSignUpWithEmailAndPasswordFailure.code(String code){
    switch (code) {
      case 'weak-password' :
        return const WSignUpWithEmailAndPasswordFailure (
            'Pleass enter a stronger password.');
      case 'invalid-email':
        return const WSignUpWithEmailAndPasswordFailure (
            'Email is not valid or badly formatted.');
      case 'email-already-in-use':
        return const WSignUpWithEmailAndPasswordFailure (
            'An account already exists for that email.');
      case 'operation-not-allowed':
        return const WSignUpWithEmailAndPasswordFailure (
            'Operation is not allowed. Please contact support.');
      case 'user-disabled':
        return const WSignUpWithEmailAndPasswordFailure (
            'This user has been disabled. Please contact support for help.');
      case 'invalid-password':
        return const WSignUpWithEmailAndPasswordFailure (
            'The provided value for the password user property is invalid. It must be a string with at least six characters.');
      case 'invalid-password-hash':
        return const WSignUpWithEmailAndPasswordFailure(
            'The password hash must be a valid byte buffer.');
      case 'invalid-password-salt':
        return const WSignUpWithEmailAndPasswordFailure(
            'The password salt must be a valid byte buffer');

      default:
        return const WSignUpWithEmailAndPasswordFailure('Default Error : Pleass enter a stronger password.');
    }
  }
}