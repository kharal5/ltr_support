###
 Copyright 2015 org.NLP4L

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
###

$ ->

  url = location.pathname.split('/')
  ltrid = url.pop()
  currentLtrid = url.pop()
  currentLtrid = url.pop()

  if(currentLtrid == "ltrdashboard")
    currentLtrUrl = "/0"
  else
    currentLtrUrl = "/" + currentLtrid
    
  ltrurl = ""
  if(ltrid != "new")
    ltrurl = "/" + ltrid
    $('#load-button').prop('disabled', false)
    $('#save-button').prop('disabled', false)
    $('#delete-button').prop('disabled', false)
  else
    $('#load-button').prop('disabled', true)
    $('#save-button').prop('disabled', true)
    $('#delete-button').prop('disabled', true)

  if(currentLtrid == ltrid)
  　　$('#delete-button').prop('disabled', true)

  
  check_input = () ->
    name = $('#name').val()
    superviseType = $('#superviseType').val()
    labelMax = $('#labelMax').val()
    modelFactryClassName = $('#modelFactryClassName').val()
    searchUrl = $('#searchUrl').val()
    featureUrl = $('#featureUrl').val()
    docUniqField = $('#docUniqField').val()

    if (name.length > 0 && superviseType.length > 0 && labelMax.length > 0 && modelFactryClassName.length > 0 && searchUrl.length > 0 && featureUrl.length > 0 && docUniqField.length > 0)
      $('#save-button').prop('disabled', false)
    else
      $('#save-button').prop('disabled', true)

  $('#name').keyup ->
    name = $('#name').val()
    check_input()
  
  $('#superviseType').keyup ->
    check_input()
    
  $('#labelMax').keyup ->
    check_input()
    
  $('#modelFactryClassName').keyup ->
    check_input()
    
  $('#searchUrl').keyup ->
    check_input()
    
  $('#featureUrl').keyup ->
    check_input()
    
  $('#docUniqField').keyup ->
    check_input()

  $('#save-button').click ->
    name = $('#name').val()
    superviseType = $('#superviseType').val()
    labelMax = $('#labelMax').val()
    modelFactryClassName = $('#modelFactryClassName').val()
    modelFactoryClassSettings = $('#modelFactoryClassSettings').val()
    searchUrl = $('#searchUrl').val()
    featureUrl = $('#featureUrl').val()
    docUniqField = $('#docUniqField').val()
    $.ajax
      url: '/ltr/config' + ltrurl,
      type: 'POST',
      contentType: 'text/json',
      data: JSON.stringify({
      	"name": name, 
      	"superviseType":superviseType,
      	"labelMax":labelMax,
      	"modelFactryClassName":modelFactryClassName,
      	"modelFactoryClassSettings":modelFactoryClassSettings,
      	"searchUrl":searchUrl,
      	"featureUrl":featureUrl,
      	"docUniqField":docUniqField
      	
      }),
      success: (data, textStatus, jqXHR) ->
        jump = '/ltrdashboard'+currentLtrUrl+'/config/' + data.ltrid
        location.replace(jump)


  $('#load-button').click ->
    jump = '/ltrdashboard/'+ltrid
    location.replace(jump)
    
  $('#delete-ltrconfig').click ->
    $.ajax
      url: '/ltr/config' + ltrurl,
      type: 'DELETE',
      success: (data, textStatus, jqXHR) ->
        jump = '/ltrdashboard'+currentLtrUrl+'/config'
        if(currentLtrid == ltrid)
          jump = '/ltrdashboard/0/config'
          
        location.replace(jump)

    