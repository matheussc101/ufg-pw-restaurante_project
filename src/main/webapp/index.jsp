<%@ include file="/views/header.html"%>
<%@ include file="/views/barra_de_menus.html"%>
		<title>Restaurante</title>
	</head>
	<body>
	<div class="container">
		<div ng-view></div>  
	</div>
	<script src="appt.js"></script>
    <script src="controllers/controllersGarcom.js"></script>
    
    <script>
		var numItens = 1;
    
		function carroClientes() {
			var carroCliente = $("input:radio[name=carroCliente]:checked").val();
			
			if(carroCliente == 1)
				$("#dadosCarro").removeClass("oculto");
			else 
				$("#dadosCarro").addClass("oculto");
							
		}
		 
		function AdicionaLinha() {
			
			
				var quantidadeItem = $("#quantidadeItem").val();
				var item           = $("#item").val();

			    var newRow = $("<tr id='linha"+numItens+"'>");
			    var cols = "";
			    
			    cols += '<td><center>'+numItens+'</center></td>';
			    cols += '<td><center>'+item+'</center></td>';
			    cols += '<td>';
			    cols += '	<center>';
			    cols += '		<span class=""><i class="fa fa-plus-square" aria-hidden="true"></i></span>';
			    cols += '		<span> '+quantidadeItem+'  </span>';
			    cols += '		<span class=""><i class="fa fa-minus-square" aria-hidden="true"></i></span>';
			    cols += '	</center>';
			    cols += '</td>';
			    cols += '<td>';
			    cols += '	<center>'
			    cols += '		<a type="button" class="btn btn-danger btn-xs" onclick="removerItem(\''+numItens+'\');"><i class="fa fa-trash-o" aria-hidden="true"></i> Remover</a>';
			    cols += '	</center>';
			    cols += '</td>';
			    
			    $("#divItensPedido").removeClass('oculto');

			    newRow.append(cols);
			    $("#itensPedido").append(newRow);
			    
			    numItens++;
			    
			    $("#quantidadeItem").val('');
				$("#item").val('');
				
				

	     }
		
		 function removerItem(numItem) {
			 alert(numItem);
			 $("#linha"+numItem).remove();
			 
		 }
		 
		 function controlaFormaPgto() {
			 
			var formaPgto = $("#selectFormaPgto").val();
			
			if (formaPgto == 1) {
				
				$("#divCheque").addClass("oculto");
				$("#divCartao").addClass("oculto");
				
				$("#divDinheiro").removeClass("oculto");
				$("#formaPgtoCupom").text("Pagamento em Dinheiro");
				
			} else if (formaPgto == 2) {
				$("#divCheque").addClass("oculto");
				$("#divDinheiro").addClass("oculto");
				
				$("#divCartao").removeClass("oculto");
				$("#formaPgtoCupom").text("Pagamento no Cartão");
				
			} else {
				$("#divCartao").addClass("oculto");
				$("#divDinheiro").addClass("oculto");
				
				$("#divCheque").removeClass("oculto");
				$("#formaPgtoCupom").text("Pagamento em Cheque");
				
			}
		 }
		
		 function calculaTroco() {
			 
			 var valorRecebido = $("#valorRecebido").val();
			 $("#troco").val(valorRecebido - 130.00);
		 }
		 
		 var map;
		 var infoWindow;

		 function initMap() {
		   map = new google.maps.Map(document.getElementById('map'), {
		     zoom: 5,
		     center: {lat: 24.886, lng: -70.268},
		     mapTypeId: google.maps.MapTypeId.TERRAIN
		   });

		   // Define the LatLng coordinates for the polygon.
		   var triangleCoords = [
		       {lat: 25.774, lng: -80.190},
		       {lat: 18.466, lng: -66.118},
		       {lat: 32.321, lng: -64.757}
		   ];

		   // Construct the polygon.
		   var bermudaTriangle = new google.maps.Polygon({
		     paths: triangleCoords,
		     strokeColor: '#FF0000',
		     strokeOpacity: 0.8,
		     strokeWeight: 3,
		     fillColor: '#FF0000',
		     fillOpacity: 0.35
		   });
		   bermudaTriangle.setMap(map);

		   // Add a listener for the click event.
		   bermudaTriangle.addListener('click', showArrays);

		   infoWindow = new google.maps.InfoWindow;
		 }

		 /** @this {google.maps.Polygon} */
		 function showArrays(event) {
		   // Since this polygon has only one path, we can call getPath() to return the
		   // MVCArray of LatLngs.
		   var vertices = this.getPath();

		   var contentString = '<b>Bermuda Triangle polygon</b><br>' +
		       'Clicked location: <br>' + event.latLng.lat() + ',' + event.latLng.lng() +
		       '<br>';

		   // Iterate over the vertices.
		   for (var i =0; i < vertices.getLength(); i++) {
		     var xy = vertices.getAt(i);
		     contentString += '<br>' + 'Coordinate ' + i + ':<br>' + xy.lat() + ',' +
		         xy.lng();
		   }

		   // Replace the info window's content and position.
		   infoWindow.setContent(contentString);
		   infoWindow.setPosition(event.latLng);

		   infoWindow.open(map);
		 }
			</script>
			
			
			<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCPmpL5-SZkkVcnH1H1kVv0-AXt6sLFk0g&signed_in=true&callback=initMap"
        async defer>
    		</script>

	
	</body>
</html>