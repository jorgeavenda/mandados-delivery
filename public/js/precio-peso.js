$(document).ready(function(){
  $('[name="peso"]').maskMoney({ thousands:'.', decimal:',', precision: 3 });
  $('[name="precio"]').maskMoney({ thousands:'.', decimal:','});
}); // fin de function ready
//para el calculo de precio a pagar en funcion de campo gramos 
$(function() {
  $('[name="peso"]').keyup(function() {
    var idpeso= "#"+$(this).attr('id');
    var idprecio = "#"+$(idpeso).siblings('[name="precio"]').attr('id');
    var value = $(this).val();
    var pmvp = $(idpeso).parents('[name="box-precio"]').find('[name="pmvp"]').text();
    var precio = Convert.string_decimal(value)*Convert.string_decimal(pmvp);
  	$(idprecio).val(formatNumber.new((precio).toFixed(2)));
  });
});
//para el calculo de gramos a comprar en funcion de campo numerico 
$(function() {
  $('[name="precio"]').keyup(function() {
    var idprecio= "#"+$(this).attr('id');
    var idpeso = "#"+$(idprecio).siblings('[name="peso"]').attr('id');
    var value = $(this).val();
    var pmvp = $(idprecio).parents('[name="box-precio"]').find('[name="pmvp"]').text();
    var gram = Convert.string_decimal(value)/Convert.string_decimal(pmvp);
    	$(idpeso).val(formatNumber.new((gram).toFixed(3)));
  });	
});
//necesario para otras funciones
var Convert = {
  string_decimal: function(value) {
    value = value.replace(/[.]/g, '').replace(',', '.');
    console.debug('1: ' + value);
    return parseFloat(value.replace(/[^0-9-.]/g, ''));
  },
  decimal_string: function(value) {
    console.debug('1: ' + value);
    value = Convert.string_decimal(value);
    console.debug('2: ' + value);
    return (value).formatMoney(2, '', '.', ',');
  }
}
//Función para dar formato a números usado en gramos para calcular precio 
var formatNumber = {
 separador: ".", // separador para los miles
 sepDecimal: ',', // separador para los decimales
 formatear:function (num){
  num +='';
  var splitStr = num.split('.');
  var splitLeft = splitStr[0];
  var splitRight = splitStr.length > 1 ? this.sepDecimal + splitStr[1] : '';
  var regx = /(\d+)(\d{3})/;
  while (regx.test(splitLeft)) {
  splitLeft = splitLeft.replace(regx, '$1' + this.separador + '$2');
  }
  return this.simbol + splitLeft  +splitRight;
 },
 new:function(num, simbol){
  this.simbol = simbol ||'';
  return this.formatear(num);
 }
}
