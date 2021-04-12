import 'package:calc_solar/solar_state.dart';
import 'package:calc_solar/calc_solar.dart';

/**
 * testedart pub get
 * 
 * Descricao do main
 */
void main(List<String> arguments) {
  print('Calculos para Projeto Fotovoltáico');
  print('<< Lista de cargas da edificação');
  // var cargas = [
  //   [2, 9, 4, 'Lampada sala', '1'],
  //   [1, 9, 6, 'Lampada Cozinha', '2'],
  //   [3, 9, 3, 'Lampada quartos', '3'],
  //   [1, 120, 5, 'Tv-Antena', '4']
  // ];
  var cargas = [
    [1, 36, 12, 'Aparelho RTLS', '1'],
  ];
  var solarState = SolarState();
  edificacao(solarState, cargas,
      edificacaoTemperaturaMaximaAnual: 26, menorRadiacaoHSP: 3.50);
  potenciaMaximaInversor(solarState, rendimentoDaPotenciaNominal: 0.5);
  rendimentoDoInversor(solarState, rendimentoDoInversor: 0.89);
  // rendimentoBancoBaterias(solarState, rendimentoDoBancoBaterias: 0.89);
  capacidadeUtil(solarState, tensaoArranjosolar: 12);
  capacidadeReal(solarState, profundidadeDescargaBateria: 0.6);
  arranjoBaterias(solarState, capacidadeDescargaC: 220, tensaoArranjosolar: 12);
  rendimentoControladorSolar(solarState, comMPPT: false);
  fatorK(solarState, 22.24);
  radiacaoSolar(solarState, 22.24);
  escolhaPainel(solarState, 0.0047, 2.93, 3.13);
  arranjoSolar(solarState);
  correnteControladorDeCargas(solarState);
  print(solarState.toString());
}
