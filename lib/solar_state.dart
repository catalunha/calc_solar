class SolarState {
  double demandaTotalDiaria;
  double demandaSimultaneaDiaria;
  double potenciaMaximaInversor;
  double rendimentoDaPotenciaNominal;
  double rendimentoDoInversor;
  double rendimentoDoBancoBaterias;
  double demandaTotalDiariaComRendimentos;
  double capacidadeUtil;
  double capacidadeReal;
  double numeroDeBateriaDoBanco;
  double energiaGeradaDiariaAhDia;
  double fatorK;
  double menorRadiacaoHSP;
  double menorRadiacaoHSPCorrigida;
  double edificacaoTemperaturaMaximaAnual;
  double painelRendimentoPorTemperatura;
  double painelImpp;
  double painelVmpp;
  double painelVoc;
  double painelIoc;
  double arranjoSolarSerie;
  double arranjoSolarParalelo;
  double controladorCargaCorrenteEntrada;

  @override
  String toString() {
    print('** SolarState:');
    print('Demanda Total Diaria [Wh/Dia]: $demandaTotalDiaria');
    print('Demanda Simultanea Diaria [W/Dia]: $demandaSimultaneaDiaria');
    print('Potencia maxima do inversor [W]: $potenciaMaximaInversor');
    print('Rendimento da potencia nominal [W]: $rendimentoDaPotenciaNominal');
    print('Rendimento do Inversor X: $rendimentoDoInversor');
    print('Rendimento do Inversor X: $rendimentoDoBancoBaterias');
    print(
        'Demanda Total Diaria com rendimento [Wh/Dia]: $demandaTotalDiariaComRendimentos');
    print('Capacidade útil [Ah]: $capacidadeUtil');
    print('Capacidade Real [Ah]: $capacidadeReal');
    print('Capacidade Real [Ah]: $capacidadeReal');
    print('Numero de bateria do banco: $numeroDeBateriaDoBanco');
    print('Energia Gerada Diaria [Ah/Dia]: $energiaGeradaDiariaAhDia');
    print('Fator K: $fatorK');
    print('menorRadiacaoHSP: $menorRadiacaoHSP');
    print('menorRadiacaoHSPCorrigida: $menorRadiacaoHSPCorrigida');
    print('painelRendimentoPorTemperatura: $painelRendimentoPorTemperatura');
    print('painelImpp: $painelImpp');
    print('painelIoc: $painelIoc');
    print('arranjoSolarSerie: $arranjoSolarSerie');
    print('arranjoSolarParalelo: $arranjoSolarParalelo');
    print('controladorCargaCorrenteEntrada: $controladorCargaCorrenteEntrada');

    return '';
  }
}
