
var i = 0;
$('#addCheckDiv').click(function(){
    $('#checkingAgencyTable').append('<tr class="d-flex flex-wrap ml-3" style="border: 1px solid #ddd; margin-bottom: 10px;"><td><div class="form-group "><label for="exampleInputEmail1">Fullcase Agency</label><select class="select2-single form-control" name="agency['+i+'][fullcase_agency_id]" id="fullcaseList"><option value="" >Select</option> @foreach($fullcaseDatas as $fdata) <option value="{{$fdata->id}}" >{{$fdata->name}}</option> @endforeach </select></div></td><td><div class="form-group"><label for="exampleInput1">Upload Document</label><input type="file" name="agency['+i+'][filename]" value="" class="form-control"></div></td></tr>');
});

$(document).on('click', '.removeCheckingTR', function(){
    $(this).parents('tr').remove();
});
