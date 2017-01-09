$( window ).load(function() {
  $(document).on("click", ".add_mean", function(){
    number_means= $(".child").length;
    code='<div class="child">'+
      '<input class="form-control" type="text" name="word[meanings_attributes]['
      +number_means+'][content]" id="word_meanings_attributes_'
      +number_means+'_content">'+
      '<label for="word_is_correct">Is correct</label>'+
      '<input name="word[meanings_attributes]['
      +number_means+'][is_correct]" type="hidden" value="0">'+
      '<input class="option_checkbox" type="checkbox" value="1" name="word[meanings_attributes]['
      +number_means+'][is_correct]"id="word_meanings_attributes_'
      +number_means+'_is_correct"><br>'
      +'<input class="destroy form-control" type="hidden" value="false" name="word[meanings_attributes]['+number_means+'][_destroy]" id="word_meanings_attributes_'+number_means+'__destroy">'
      +'<a class="remove_mean" href="javascript:void(0)">remove</a>'
      +'</div>';
  $('#area_child').append(code);
  registerCheckBoxEvent();
  });

  $(document).on("click", ".remove_mean", function(){
    $(this).prev().val("true");
    $(this).closest('.child').slideUp();

  });

  registerCheckBoxEvent();
})

function registerCheckBoxEvent() {
  $(".option_checkbox").change( function() {
      $("#" + this.id).prop("checked", true);
    var allOptionCheckboxes = $(".option_checkbox");
    for (var i = 0; i < allOptionCheckboxes.length; i++) {
      var optionCheckbox = allOptionCheckboxes[i];
      if (optionCheckbox.id != this.id)
          $("#" + optionCheckbox.id).prop("checked", false);
    }
  });
}
