void main() {
  print('Calculos para Projeto Fotovoltáico');
  print('** Entrada: Lista de cargas');
  print(
      "[Quantidade de aparelhos, Potencia em W, Horas de utilização, 'Descricao da carga']");
  List<List> cargaEdificacao = [
    // [Quantidade de aparelhos, Potencia em W, Horas de utilização, 'Descricao da carga']
    [2, 9, 4, 'Lampada sala'],
    [1, 9, 6, 'Lampada Cozinha'],
    [3, 9, 3, 'Lampada quartos'],
    [1, 120, 5, 'Tv-Antena']
  ];
  print('Cargas e potencia diaria Wh/Dia');
  print(
      'Quantidade de aparelhos | Potencia em W | Horas de utilização | Potencia diária Wh/Dia | Descricao da carga ');

  double demandaEnergeticaDiaria = 0;

  for (var item in cargaEdificacao) {
    print(
        '${item[0]} | ${item[1]} | ${item[2]} | ${item[0] * item[1] * item[2]} | ${item[3]}');
    demandaEnergeticaDiaria =
        demandaEnergeticaDiaria + (item[0] * item[1] * item[2]);
  }
  print('Demanda energetica diária Wh/Dia: $demandaEnergeticaDiaria');

  // Potencia total Demanda diária
  double potenciaTotalDiaria = 0;
  for (var item in cargaEdificacao) {
    print('${item[0]} | ${item[1]} | ${item[3]}');
    potenciaTotalDiaria = potenciaTotalDiaria + (item[0] * item[1]);
  }
  print('Potencia total diária W: $potenciaTotalDiaria');
  print('** Entrada: Eficiencia do inversor (%)');
  double eficienciaDoInversor = 0.9;
  print(
      'Demanda energética diária com eficiencia do inversor \$\\dfrac{Wh}{Dia}\$: ${demandaEnergeticaDiaria / eficienciaDoInversor}');
  print('Rendimento Global - R');
  print('** Entrada: \$K_A\$ (%)');
  double K_A = 0.1;
  print('** Entrada: \$K_b\$ (%)');
  double K_b = 0.1;
  print('** Entrada: \$K_v\$ (%)');
  double K_v = 0.1;
}
