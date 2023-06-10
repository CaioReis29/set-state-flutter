

class imcState {

  final double imc;

  imcState({
    required this.imc
    });
}

class imcStateLoading extends imcState {

  imcStateLoading() : super(imc: 0);

}