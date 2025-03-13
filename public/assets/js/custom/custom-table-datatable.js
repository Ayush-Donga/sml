/*
---------------------------------------
    : Custom - Table Datatable js :
---------------------------------------
*/
"use strict";
$(document).ready(function() {
    /* -- Table - Datatable -- */
    $('#datatable').DataTable({
        responsive: true,


    });
    $('#default-datatable').DataTable( {
        "order": [[ 3, "desc" ]],
        responsive: true,
        "fnRowCallback" : function(nRow, aData, iDisplayIndex){
            $("td:first", nRow).html(iDisplayIndex +1);
            return nRow;
            },
    } );
    var table = $('#datatable-buttons').DataTable({
        lengthChange: true,
        responsive: true,
        buttons: ['copy', 'csv', 'excel', 'pdf', 'print'],
        lenghtmenu : [10,20,25,50,100,200,500]
    });
    table.buttons().container().appendTo('#datatable-buttons_wrapper .col-md-6:eq(0)');
});



$(document).ready(function() {
    /* -- Table - Datatable -- */
    $('#datatable').DataTable({
        responsive: true,


    });
    $('#table-buttons-allclaim').DataTable( {
        "order": [[ 3, "desc" ]],
        responsive: true,
        "fnRowCallback" : function(nRow, aData, iDisplayIndex){
            $("td:first", nRow).html(iDisplayIndex +1);
            return nRow;
            },
    } );
    var table = $('#datatable-buttons-allclaim').DataTable({
        lengthChange: true,
        responsive: true,
        buttons: ['copy', 'csv', 'excel', 'pdf', 'print'],
        lengthMenu : [10, 20, 50, 100, 200, 300 ,400 ,500]
    });
    table.buttons().container().appendTo('#datatable-buttons-allclaim_wrapper .col-md-6:eq(0)');
});


$(document).ready(function() {
    /* -- Table - Datatable -- */
    $('#datatable1').DataTable({
        responsive: true,


    });
    $('#table-buttons-dashbord').DataTable( {
        "order": [[ 3, "desc" ]],
        responsive: true,
        "fnRowCallback" : function(nRow, aData, iDisplayIndex){
            $("td:first", nRow).html(iDisplayIndex +1);
            return nRow;
            },
    } );
    var table = $('#datatable-buttons-dashbord').DataTable({
        lengthChange: true,
        responsive: true,
        buttons: ['copy', 'csv', 'excel', 'pdf', 'print'],
        lengthMenu : [10, 20, 50, 100]
    });
    table.buttons().container().appendTo('#datatable-buttons-dashbord_wrapper .col-md-6:eq(0)');
});

$(document).ready(function() {
    /* -- Table - Datatable -- */
    $('#datatable2').DataTable({
        responsive: true,


    });
    $('#table-buttons-dash').DataTable( {
        "order": [[ 3, "desc" ]],
        responsive: true,
        "fnRowCallback" : function(nRow, aData, iDisplayIndex){
            $("td:first", nRow).html(iDisplayIndex +1);
            return nRow;
            },
    } );
    var table = $('#datatable-buttons-dash').DataTable({
        lengthChange: true,
        responsive: true,
        buttons: ['copy', 'csv', 'excel', 'pdf', 'print'],
        lengthMenu : [10, 20, 50, 100]
    });
    table.buttons().container().appendTo('#datatable-buttons-dash_wrapper .col-md-6:eq(0)');
});

$(document).ready(function() {
    /* -- Table - Datatable -- */
    $('#datatable3').DataTable({
        responsive: true,


    });
    $('#table-buttons-dashbo').DataTable( {
        "order": [[ 3, "desc" ]],
        responsive: true,
        "fnRowCallback" : function(nRow, aData, iDisplayIndex){
            $("td:first", nRow).html(iDisplayIndex +1);
            return nRow;
            },
    } );
    var table = $('#datatable-buttons-dashbo').DataTable({
        lengthChange: true,
        responsive: true,
        buttons: ['copy', 'csv', 'excel', 'pdf', 'print'],
        lengthMenu : [10, 20, 50, 100]
    });
    table.buttons().container().appendTo('#datatable-buttons-dashbo_wrapper .col-md-6:eq(0)');
});

$(document).ready(function() {
    /* -- Table - Datatable -- */
    $('#datatable4').DataTable({
        responsive: true,


    });
    $('#table-buttons-dashbor').DataTable( {
        "order": [[ 3, "desc" ]],
        responsive: true,
        "fnRowCallback" : function(nRow, aData, iDisplayIndex){
            $("td:first", nRow).html(iDisplayIndex +1);
            return nRow;
            },
    } );
    var table = $('#datatable-buttons-dashbor').DataTable({
        lengthChange: true,
        responsive: true,
        buttons: ['copy', 'csv', 'excel', 'pdf', 'print'],
        lengthMenu : [10, 20, 50, 100]
    });
    table.buttons().container().appendTo('#datatable-buttons-dashbor_wrapper .col-md-6:eq(0)');
});

$(document).ready(function() {
    /* -- Table - Datatable -- */
    $('#datatable5').DataTable({
        responsive: true,


    });
    $('#table-buttons-dashbordd').DataTable( {
        "order": [[ 3, "desc" ]],
        responsive: true,
        "fnRowCallback" : function(nRow, aData, iDisplayIndex){
            $("td:first", nRow).html(iDisplayIndex +1);
            return nRow;
            },
    } );
    var table = $('#datatable-buttons-dashbordd').DataTable({
        lengthChange: true,
        responsive: true,
        buttons: ['copy', 'csv', 'excel', 'pdf', 'print'],
        lengthMenu : [10, 20, 50, 100]
    });
    table.buttons().container().appendTo('#datatable-buttons-dashbordd_wrapper .col-md-6:eq(0)');
});

$(document).ready(function() {
    /* -- Table - Datatable -- */
    $('#datatable6').DataTable({
        responsive: true,


    });
    $('#table-buttons-dashbordd').DataTable( {
        "order": [[ 3, "desc" ]],
        responsive: true,
        "fnRowCallback" : function(nRow, aData, iDisplayIndex){
            $("td:first", nRow).html(iDisplayIndex +1);
            return nRow;
            },
    } );
    var table = $('#datatable-buttons-datefilter').DataTable({
        lengthChange: true,
        responsive: true,
        buttons: ['copy', 'csv', 'excel', 'pdf', 'print'],
        lengthMenu : [10, 20, 50, 100]
    });
    table.buttons().container().appendTo('#datatable-buttons-datefilter_wrapper .col-md-6:eq(0)');
});

$(document).ready(function() {
    /* -- Table - Datatable -- */
    $('#datatable7').DataTable({
        responsive: true,
    });
    $('#table-buttons-report').DataTable( {
        "order": [[ 3, "desc" ]],
        responsive: true,
        "fnRowCallback" : function(nRow, aData, iDisplayIndex){
            $("td:first", nRow).html(iDisplayIndex +1);
            return nRow;
            },
    } );
    var table = $('#datatable-buttons-report').DataTable({
        lengthChange: true,
        responsive: true,
        buttons: ['copy', 'csv', 'excel', 'pdf', 'print'],
        lengthMenu : [10, 20, 50, 100]
    });
    table.buttons().container().appendTo('#datatable-buttons-report_wrapper .col-md-6:eq(0)');
});

// $(document).ready(function() {
//     /* -- Table - Datatable -- */
//     $('#datatable2').DataTable({
//         responsive: true
//     });
//     $('#default-datatable2').DataTable( {
//         "order": [[ 3, "desc" ]],
//         responsive: true,
//         "fnRowCallback" : function(nRow, aData, iDisplayIndex){
//             $("td:first", nRow).html(iDisplayIndex +1);
//             return nRow;
//             },
//     } );
//     var table = $('#datatable-buttons2').DataTable({
//         lengthChange: false,
//         responsive: true,
//         buttons: ['copy', 'csv', 'excel', 'pdf', 'print']
//     });
//     table.buttons().container().appendTo('#datatable-buttons_wrapper .col-md-6:eq(0)');
// });

// $(document).ready(function() {
//     /* -- Table - Datatable -- */
//     $('#datatable3').DataTable({
//         responsive: true
//     });
//     $('#default-datatable3').DataTable( {
//         "order": [[ 3, "desc" ]],
//         responsive: true,

//         "fnRowCallback" : function(nRow, aData, iDisplayIndex){
//             $("td:first", nRow).html(iDisplayIndex +1);
//             return nRow;
//             },
//     } );
//     var table = $('#datatable-buttons3').DataTable({
//         lengthChange: false,
//         responsive: true,
//         buttons: ['copy', 'csv', 'excel', 'pdf', 'print']
//     });
//     table.buttons().container().appendTo('#datatable-buttons_wrapper .col-md-6:eq(0)');
// });
// $(document).ready(function() {
//     /* -- Table - Datatable -- */
//     $('#datatable4').DataTable({
//         responsive: true
//     });
//     $('#default-datatable4').DataTable( {
//         "order": [[ 3, "desc" ]],
//         responsive: true,

//         "fnRowCallback" : function(nRow, aData, iDisplayIndex){
//             $("td:first", nRow).html(iDisplayIndex +1);
//             return nRow;
//             },
//     } );
//     var table = $('#datatable-buttons3').DataTable({
//         lengthChange: false,
//         responsive: true,
//         buttons: ['copy', 'csv', 'excel', 'pdf', 'print']
//     });
//     table.buttons().container().appendTo('#datatable-buttons_wrapper .col-md-6:eq(0)');
// });

// $(document).ready(function() {
//     /* -- Table - Datatable -- */
//     $('#datatable5').DataTable({
//         responsive: true
//     });
//     $('#default-datatable5').DataTable( {
//         "order": [[ 3, "desc" ]],
//         responsive: true,

//         "fnRowCallback" : function(nRow, aData, iDisplayIndex){
//             $("td:first", nRow).html(iDisplayIndex +1);
//             return nRow;
//             },
//     } );
//     var table = $('#datatable-buttons3').DataTable({
//         lengthChange: false,
//         responsive: true,
//         buttons: ['copy', 'csv', 'excel', 'pdf', 'print']
//     });
//     table.buttons().container().appendTo('#datatable-buttons_wrapper .col-md-6:eq(0)');
// });
