import 'package:calc_solar/solar_state.dart';

int calculate() {
  return 6 * 7;
}

/**
 * << Entrada de dados
 * Lista de cargas da edificação
 * * Quantidade de aparelhos
 * * Potencia em W
 * * Horas de utilização
 * * Descricao da carga
 * * idu da carga
 */
void edificacao(SolarState solarState, var cargasDaEdificacao,
    {double edificacaoTemperaturaMaximaAnual, double menorRadiacaoHSP}) {
  solarState.edificacaoTemperaturaMaximaAnual = 26;
  solarState.menorRadiacaoHSP = 2.94;
  cargasDaEdificacao2String(cargasDaEdificacao);
  demandaTotalDiaria(solarState, cargasDaEdificacao);
  demandaSimultaneaDiaria(solarState, cargasDaEdificacao);
}

/**
 * Imprime as cargas da edificação
 */
void cargasDaEdificacao2String(List<List> cargasDaEdificacao) {
  print('>> Cargas da Edificação');
  print(
      'Quantidade de aparelhos | Potencia em W | Horas de utilização | Descricao da carga | Potencia diária Wh/Dia');
  for (var item in cargasDaEdificacao) {
    print(
        '${item[0]} | ${item[1]} | ${item[2]} | ${item[0] * item[1] * item[2]} | ${item[3]}');
  }
}

/**
 * Demanda Total Diaria \\(\\dfrac{Wh}{Dia}\\).
 * 
 * Soma do Produto da Quantidade de cada aparelho pela Pontencia de cada aparelho e seu tempo de utilização
 */
void demandaTotalDiaria(SolarState solarState, List<List> cargasDaEdificacao) {
  var demandaTotalDiaria = 0.0;
  for (var item in cargasDaEdificacao) {
    demandaTotalDiaria = demandaTotalDiaria + (item[0] * item[1] * item[2]);
  }
  print('>> Demanda Total Diária Wh/Dia: $demandaTotalDiaria');

  solarState.demandaTotalDiaria = demandaTotalDiaria;
  solarState.demandaTotalDiariaComRendimentos = demandaTotalDiaria;
}

/**
 * Demanda Simultanea Diaria \\(\\dfrac{W}{Dia}\\).
 * 
 * Soma do Produto da Quantidade de cada aparelho pela sua Pontencia
 */
void demandaSimultaneaDiaria(
    SolarState solarState, List<List> cargasDaEdificacao) {
  var demandaSimultaneaDiaria = 0.0;
  for (var item in cargasDaEdificacao) {
    demandaSimultaneaDiaria = demandaSimultaneaDiaria + (item[0] * item[1]);
  }
  print('>> Demanda Simultanea Diaria W/Dia: $demandaSimultaneaDiaria');

  solarState.demandaSimultaneaDiaria = demandaSimultaneaDiaria;
}

/**
 * Potencia maxima do inversor
 * 
 * Um inversor trabalha melhor entre 50% a 70% da sua potencia nominal. Então podemos calcular
 * \\(PotenciaNominalInversorDesconhecido*0.5=DemandaSimultaneaDiaria\\)
 * 
 * Para um exemplo temos:
 * 
 * \\(InversorX*0.5=174\\)
 * 
 * \\(InversorX=\\dfrac{174}{0.5}\\)
 * 
 * \\(InversorX=348\\)
 * 
 * Ou
 * 
 * \\(InversorX*0.7=174\\)
 * 
 * \\(InversorX=\\dfrac{174}{0.7}\\)
 * 
 * \\(InversorX=248\\)
 * 

 */
void potenciaMaximaInversor(SolarState solarState,
    {double rendimentoDaPotenciaNominal}) {
  solarState.rendimentoDaPotenciaNominal = rendimentoDaPotenciaNominal;

  solarState.potenciaMaximaInversor =
      solarState.demandaSimultaneaDiaria / rendimentoDaPotenciaNominal;

  print(
      '>> Potencia maxima do Inversor com rendimento de $rendimentoDaPotenciaNominal será ${solarState.potenciaMaximaInversor} [W]: ');
}

/**
 * Rendimento do inversor
 */
void rendimentoDoInversor(SolarState solarState,
    {double rendimentoDoInversor}) {
  solarState.rendimentoDoInversor = rendimentoDoInversor;
  solarState.demandaTotalDiariaComRendimentos =
      solarState.demandaTotalDiariaComRendimentos / rendimentoDoInversor;

  print(
      '>> Rendimento do Inversor X a $rendimentoDoInversor. Demanda Total Diaria com rendimento [Wh/Dia]: ${solarState.demandaTotalDiariaComRendimentos}');
}

/**
 * Rendimento Global do banco de baterias
 * 
 * Dado por \\(R=1-((1-K_b-K_v)*K_A*\\dfrac{N}{P_d})-K_b-K_v\\)
 * 
 * em que:
 * 
 * K_A são perdas por auto-descarga em torno de 0.25 ao dia
 * 
 * K_b são perdas na bateria em torno de 0.05 a 0.10.
 * 
 * K_v são outras perdas ou fator de segurança em torno de 0.05 a 0.15
 * 
 * N quantidade de dias de autonomia 
 * 
 * P_d é a profundidade de descarga
 * 
 * Geralmente se usa entre 0.87 a 0.91, usamos 0.89
 */
void rendimentoBancoBaterias(SolarState solarState,
    {double rendimentoDoBancoBaterias = 0.89}) {
  solarState.rendimentoDoBancoBaterias = rendimentoDoBancoBaterias;

  solarState.demandaTotalDiariaComRendimentos =
      solarState.demandaTotalDiariaComRendimentos / rendimentoDoBancoBaterias;
  print(
      '>> Rendimento do banco de baterias $rendimentoDoBancoBaterias. Demanda Total Diaria com rendimento [Wh/Dia]: ${solarState.demandaTotalDiariaComRendimentos}');
}

/**
 * Capacidade útil - \\(C_u\\)
 * \\(C_u=\\dfrac{demandaTotalComRendimento*autonomiaBaterias}{tensaoArranjoSolar}\\)
 * 
 * A autonomia é definida pelo cliente, nao menos que a normal de 2 dias. Em media usa-se 3 dias.
 * 
 * A tensão do arranjo solar geralmente é 24V
 */
void capacidadeUtil(SolarState solarState,
    {int diasAutonomiaBaterias = 3, int tensaoArranjosolar = 24}) {
  var capacidadeUtil = solarState.demandaTotalDiariaComRendimentos *
      diasAutonomiaBaterias /
      tensaoArranjosolar;
  solarState.capacidadeUtil = capacidadeUtil;
  print('Capacidade útil [Ah]: ${solarState.capacidadeUtil}');
}

/**
 * Capacidade Real - \\(C_R\\)
 * \\(C_R=\\dfrac{capacidadeUtil}{profundidadeDeDescarga}\\)
 * 
 * A profundidade de descarga é definida pelo cliente. Deve ficar menor que 60%.
 * 
 * Podendo descarregar 20% a cada dia. 3*20%=60% é uma media boa.
 * 
 * Outros contextos recalcular
 */
void capacidadeReal(SolarState solarState,
    {double profundidadeDescargaBateria = 0.6}) {
  solarState.capacidadeReal =
      solarState.capacidadeUtil / profundidadeDescargaBateria;
  print('Capacidade Real [Ah]: ${solarState.capacidadeReal}');
}

/**
 * arranjo de baterias
 * A tensão do arranjo solar é 24V. A tensão das bateria é 12V. 
 * Precisamos colocar as baterias de 12V em série para alcançar a tensão de 24V conforme sistema solar que vai carrega-las. Em geral duas em série atendem.
 * 
 * Em paralelo vai a quantidade em função da capacidade real de descarga ser maior do que a capacidade nominal. Precisamos então calcular quantas em paralelo.
 * 
 * O valor entre elas 
 */
void arranjoBaterias(SolarState solarState,
    {int tensaoArranjosolar = 24,
    int tensaoBaterias = 12,
    double capacidadeDescargaC}) {
  var bateriasEmSeriePelaTensaoSolarEBateria =
      tensaoArranjosolar / tensaoBaterias;
  var bateriasEmParaleloPelaCapacidadeRealNominal =
      solarState.capacidadeReal / capacidadeDescargaC;
  var numeroDeBateriaDoBanco = bateriasEmSeriePelaTensaoSolarEBateria *
      bateriasEmParaleloPelaCapacidadeRealNominal;
  solarState.numeroDeBateriaDoBanco = numeroDeBateriaDoBanco;
  print(
      'bateriasEmSeriePelaTensaoSolarEBateria: ${bateriasEmSeriePelaTensaoSolarEBateria}');
  print(
      'bateriasEmParaleloPelaCapacidadeRealNominal: ${bateriasEmParaleloPelaCapacidadeRealNominal}');
  print('Quantidade de baterias: ${solarState.numeroDeBateriaDoBanco}');
}

void rendimentoControladorSolar(SolarState solarState,
    {bool comMPPT = true, double rendimento = 0.9}) {
  if (comMPPT) {
    solarState.demandaTotalDiariaComRendimentos =
        solarState.demandaTotalDiariaComRendimentos;
    print(
        'controlador com MPPT rendimento 100%. Demanda total diária com rendimentos: ${solarState.demandaTotalDiariaComRendimentos}');
  } else {
    solarState.demandaTotalDiariaComRendimentos =
        solarState.demandaTotalDiariaComRendimentos / rendimento;
    print(
        'controlador sem MPPT com rendimento ${rendimento}. Demanda total diária com rendimentos: ${solarState.demandaTotalDiariaComRendimentos}');
    solarState.energiaGeradaDiariaAhDia =
        solarState.demandaTotalDiariaComRendimentos / 24;
  }
}

/**
 * Correção da radiação para superficies inclinadas - metodo IDAE
 * Fator K
 * 
 * A correção empirica da inclinação é inclinacaoCorrigida=latitude + (latitude/4) 
 * 
 * Com base na latitude e na inclinação corrigida consultamos a tabela do maior valor.
 */
void fatorK(SolarState solarState, double latitude) {
  var inclinacaoCorrigida = latitude + latitude / 4;
  // Com base na latitude e na inclinação corrigida consultamos na tabela o maior valor.
  solarState.fatorK = 1.21; // alterar este valor para o real
}

/**
 * Radiação solar diária media mensal - kWh/m2/Dia
 * Acessar cresesb e coletar radiacao para a latitude informada.
 * 
 * Com base nos valores mensais pegar o menor valor
 */
void radiacaoSolar(SolarState solarState, double latitude) {
  // Com base nos valores mensais pegar o menor valor
  solarState.menorRadiacaoHSPCorrigida =
      solarState.fatorK * solarState.menorRadiacaoHSP;
}

/**
 * Escolha do Painel Fotovoltaico
 * 
 * O Rendimento com base na temperatura precisa ser corrigido com base no local de instalacao
 * 
 * Consultar o dataSheet do painel solar e ver a potencia pico em funcao da temperatura
 * Neste exemplo Potencia Pico: 0.47%/ºC
 * 
 * A correção é feita multiplicando a temperatura onde o painel será instalado por este fator
 * Exemplo: Instalado numa localidade de tempertura media anual de 26ºC corrigindo teremos.
 * 
 * 26*0.47% = 12.2%
 * 
 * Impp é a corrente de maxima potencia.
 */
void escolhaPainel(SolarState solarState, double painelFatorCorrecaoTemperatura,
    double painelImpp, double painelIoc) {
  solarState.painelRendimentoPorTemperatura = 1 -
      (painelFatorCorrecaoTemperatura *
          solarState.edificacaoTemperaturaMaximaAnual);
  solarState.painelImpp = painelImpp;
  solarState.painelIoc = painelIoc;
}

/**
 * Quantidade de modulos fotovoltaicos
 * 
 * \\(arranjoSerie=\\dfrac{tensaoControladorDeCargas}{tensaoModuloSolar}\\)
 * 
 * \\(arranjoParalelo=\\dfrac{energiaGeradaDiariaAhDia}{painelRendimentoPorTemperatura*painelImpp*menorRadiacaoHSPCorrigida}\\)
 *  
 */
void arranjoSolar(
  SolarState solarState, {
  int tensaoArranjosolar = 24,
  int tensaoPainel = 12,
}) {
  solarState.arranjoSolarSerie = tensaoArranjosolar / tensaoPainel;
  var correnteGeracao = solarState.energiaGeradaDiariaAhDia;
  var correnteCapazDeGerar = solarState.painelRendimentoPorTemperatura *
      solarState.painelImpp *
      solarState.menorRadiacaoHSPCorrigida;
  solarState.arranjoSolarParalelo = correnteGeracao / correnteCapazDeGerar;
  print('Paineis em serie devido a tensão: ${solarState.arranjoSolarSerie}');
  print(
      'Paineis em paralelo devido a geracao: ${solarState.arranjoSolarParalelo}');
}

/**
 * Corrente de entrada do controlador de cargas (do painel para a bateria)
 * 
 * Sem MPPT
 * 
 * \\(controladorCargaCorrenteEntrada=painelIoc*arranjoSolarParalelo*coeficienteDeSeguranca\\)
 * 
 */
void correnteControladorDeCargas(SolarState solarState,
    {double coeficienteDeSeguranca = 1.25}) {
  solarState.controladorCargaCorrenteEntrada = solarState.painelIoc *
      solarState.arranjoSolarParalelo *
      coeficienteDeSeguranca;
  print(
      'Sem MPPT: Corrente de entrada do controlador de cargas (do painel para a bateria): ${solarState.controladorCargaCorrenteEntrada}');
}
