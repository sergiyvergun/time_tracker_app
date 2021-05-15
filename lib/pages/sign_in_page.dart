import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_app/blocs/sign_in/sign_in_bloc.dart';
import 'package:time_tracker_app/common_widgets/show_exception_alert_dialog.dart';
import 'package:time_tracker_app/pages/email_sign_in_page.dart';
import 'package:time_tracker_app/common_widgets/sign_in_button.dart';
import 'package:time_tracker_app/services/auth.dart';

class SignInPage extends StatelessWidget {
  final SignInBloc bloc;

  const SignInPage({Key key, @required this.bloc}) : super(key: key);

  static Widget create(BuildContext context) {
    return Provider<SignInBloc>(
      create: (_) => SignInBloc(),
      dispose: (_,bloc)=>bloc.dispose(),
      child: Consumer<SignInBloc>(
          builder: (_, bloc, __) => SignInPage(bloc: bloc)),
    );
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      bloc.setIsLoading(true);
      await Provider.of<Auth>(context, listen: false).signInAnonymously();
    } on Exception catch (e) {
      showSignInError(context, e);
    } finally {
      bloc.setIsLoading(false);
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      bloc.setIsLoading(true);
      await Provider.of<Auth>(context, listen: false).signInWithGoogle();
    } catch (e) {
      showSignInError(context, e);
    } finally {
      bloc.setIsLoading(false);
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    try {
      bloc.setIsLoading(true);
      await Provider.of<Auth>(context, listen: false).signInWithFacebook();
    } catch (e) {
      showSignInError(context, e);
    } finally {
      bloc.setIsLoading(false);
    }
  }

  void signInWithEmail(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) {
          return EmailSignInPage();
        }));
  }

  void showSignInError(BuildContext context, Exception exception) {
    if (exception is FirebaseException &&
        exception.code == 'ERROR ABORTED BY USER') {
      return;
    }
    showExceptionAlertDialog(context,
        title: 'Sign in failed', exception: exception);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Time Tracker'),
      //   elevation: 0,
      // ),
      body: StreamBuilder<bool>(
          stream: bloc.isLoadingStream,
          initialData: false,
          builder: (context, snapshot) {
            bool isLoading = snapshot.data;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(flex: 4),
                  Text('Sign in',
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.w600)),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      width: 17,
                      height: isLoading ? 17 : 0,
                      child: FittedBox(child: CircularProgressIndicator()),
                    ),
                  ),
                  Spacer(),
                  SignInButton(
                    title: 'Sign in with Google',
                    primaryColor: Colors.orange[400],
                    onPressed:
                        isLoading ? null : () => _signInWithGoogle(context),
                  ),
                  Gap(13),
                  SignInButton(
                    title: 'Sign in with Facebook',
                    primaryColor: Colors.blueAccent[200],
                    onPressed:
                        isLoading ? null : () => _signInWithFacebook(context),
                  ),
                  Gap(13),
                  SignInButton(
                    title: 'Sign in with Email',
                    primaryColor: Colors.green[400],
                    onPressed:
                        isLoading ? null : () => signInWithEmail(context),
                  ),
                  Gap(30),
                  Text('Or',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                  Gap(20),
                  SignInButton(
                    title: 'Continue anonymously',
                    onPressed:
                        isLoading ? null : () => _signInAnonymously(context),
                    primaryColor: Colors.blueGrey[400],
                  ),
                  Gap(35),
                ],
              ),
            );
          }),
    );
  }
}
