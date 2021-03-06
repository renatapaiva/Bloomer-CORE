/*
* Bloomer - Desempenho
*/

var idJogo;

/* Selectors */

$(document).ready(function(){
	$("#jump_menu_usuarios").hide();
	getJogos();
});

$("#jump_menu_jogos").ready(function(){
	$("#jump_menu_jogos").change(function(){

		idJogo = $("#jump_menu_jogos").val();
		
		$.getJSON("http://localhost:8080/Bloomer-CORE/jogos/" + idJogo +"/partidas", function(json){ 
		
		// GET http://localhost/Bloomer-CORE/jogos/{idJogo}/partidas
			montarTabela(json);
			montarGrafico(json);
		});

		ajax();
	});
});

$("#jump_menu_usuarios").ready(function(){
	$("#jump_menu_usuarios").change(function(){
		
		idUsuario = $("#jump_menu_usuarios").val();
		
		$.getJSON("http://localhost:8080/Bloomer-CORE/jogos/"+idJogo+"/desempenho/" + idUsuario, function(json){ 

			// GET http://localhost/Bloomer-CORE/jogos/{idJogo}/partidas/{idUsuario}
			montarTabela(json);
			montarGrafico(json);
		});
	});
});

/* Functions */

function getJogos(){

		$.getJSON("http://localhost:8080/Bloomer-CORE/jogos", function(json){ 
		// GET "http://localhost:8080/Bloomer-CORE/jogos"

		var options = '<option value="null">Escolha um jogo...</option>';

		for (i = 0; i < json.length; i++){
			options += '<option value="' + json[i].id + '">' + json[i].nome + '</option>';
		}

		$("#jump_menu_jogos").html(options);
	});
};

function ajax(){

	$.ajax({
		//type: "GET",
		url: "http://localhost:8080/Bloomer-CORE/jogos/" + idJogo + "/usuarios", 
		
		// GET http://localhost/Bloomer-CORE/jogos/{idJogo}/usuarios
		//data: {nome: value},
		dataType: "json",
		success: function(json){

			var options = '<option value="null">Escolha um usuário...</option>';

			for (i = 0; i < json.length; i++){
				options += '<option value="' + json[i].id + '">' + json[i].nome + '</option>';
			}

			$("#jump_menu_usuarios").html(options);
		}
	});

	if($('#jump_menu_usuarios').is(':hidden')) {
    	$("#jump_menu_usuarios").show();
	};
};

function montarTabela(json){

	ifExistsRemove($("#tabela"));

	var $div = $('<div /></br>').appendTo('body');
	$div.attr('id', 'tabela_desempenho');

	var table = $('<table widtd="1000" border="1" cellspacing="0" style="text-align:center"></table>').attr('id', 'tabela');

	var header = '<tr><th rowspan="2">Data/Hora</th><th rowspan="2">Acertos (%)</th><th rowspan="2">Concluiu</th><th rowspan="2">Escore</th>';

	for (h = 0; h < json.questoes.length; h++){
		header += '<th style="line-height:0" rowspan="2"><h4>Questão ' + (h + 1) + '</h4><h4>Gabarito: ' + json.questoes[h].gabarito + '</h4></th>';
	}

	header += '</tr><tr></tr>';
	table.append(header);

	for (j=0; j < json.partidas.length; j++){
	    var row = '<tr><td>' + json.partidas[j].dataHora + '</td><td>' + json.partidas[j].acerto +
	    			'</td><td>' + json.partidas[j].concluiu + '</td><td>' + json.partidas[j].escore + '</td>';

	    for (k=0; k < json.partidas[0].respostas.length; k++){
	    	row += '<td>' + json.partidas[0].respostas[k].conteudo + '</td>';
	    }

	    row += '</tr>';
	    table.append(row);
	}

	$("#tabela_desempenho").append(table);
};

function montarGrafico(json){

	ifExistsRemove($("#grafico"));

	var $div = $('<div />').appendTo('body');
	$div.attr('id', 'grafico');
	$div.css('height', '500px');
	$div.css('width', '700px');

	// Alocando os arrays
	var score = new Array(json.partidas.length);
	var acertos = new Array(json.partidas.length);

		for (var i = 0; i < json.partidas.length; i++) {
			score[i] = new Array(2);
			acertos[i] = new Array(2);
		}

	for (var j=0; j < json.partidas.length; j++){

				score [j][0] = json.partidas[j].idPartida;
				score [j][1] = json.partidas[j].escore;

				acertos [j][0] = json.partidas[j].idPartida;
				acertos [j][1] = json.partidas[j].acerto;
	}

    plot1 = $.jqplot("grafico", [score, acertos], {
        // Turns on animatino for all series in this plot.
        animate: true,
        // Will animate plot on calls to plot1.replot({resetAxes:true})
        animateReplot: true,
        cursor: {
            show: true,
            zoom: true,
            looseZoom: true,
            showTooltip: false
        },
        series:[
            {
                pointLabels: {
                    show: true
                },
                renderer: $.jqplot.BarRenderer,
                showHighlight: false,
                yaxis: 'y2axis',
                rendererOptions: {
                    // Speed up the animation a little bit.
                    // This is a number of milliseconds.
                    // Default for bar series is 3000.
                    animation: {
                        speed: 2500
                    },
                    barWidth: 30,
                    barPadding: 0,
                    barMargin: 0,
                    highlightMouseOver: false
                }
            },
            {
                rendererOptions: {
                    // speed up the animation a little bit.
                    // This is a number of milliseconds.
                    // Default for a line series is 2500.
                    animation: {
                        speed: 2000
                    }
                }
            }
        ],
        axesDefaults: {
            pad: 0
        },
        axes: {
            // These options will set up the x axis like a category axis.
            xaxis: {
                tickInterval: 1,
                drawMajorGridlines: false,
                drawMinorGridlines: true,
                drawMajorTickMarks: false,
                tickOptions: {
                    formatString: "%'s"
                },
                rendererOptions: {
                tickInset: 0.5,
                minorTicks: 1
            }
            },
            yaxis: {
                tickOptions: {
                    formatString: "%'s"
                },
                rendererOptions: {
                    forceTickAt0: true
                }
            },
            y2axis: {
                tickOptions: {
                    formatString: "%'s"
                },
                rendererOptions: {
                    // align the ticks on the y2 axis with the y axis.
                    alignTicks: true,
                    forceTickAt0: true
                }
            }
        },
        highlighter: {
            show: true,
            showLabel: true,
            tooltipAxes: 'y',
            sizeAdjust: 7.5 , tooltipLocation : 'ne'
        }
    });
};

function ifExistsRemove(element){
	if(element !== null){
		element.remove();
	}
};
