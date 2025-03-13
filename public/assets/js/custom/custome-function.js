// Daynamic validation check file extention genrated error return 
function checkFileExtensions(event, index) {
    const file = event.target.files[0];
    const fileName = file.name;
    const fileExtension = fileName.split('.').pop().toLowerCase();

    const errorMessageDiv = $(event.target).closest('td').find(`#errorMessageDiv${index}`);

    if (fileExtension === 'csv') {
        event.target.value = ''; // Clear the selected file
        errorMessageDiv.html('<strong>Error:</strong> CSV file not allowed.');
        errorMessageDiv.addClass('alert alert-danger');
    } else if (fileExtension === 'xlsx') {
        event.target.value = ''; // Clear the selected file
        errorMessageDiv.html('<strong>Error:</strong> XLSX file not allowed.');
        errorMessageDiv.addClass('alert alert-danger');
    } else {
        errorMessageDiv.html(''); // Clear the error message
        errorMessageDiv.removeClass('alert alert-danger');
    }
}