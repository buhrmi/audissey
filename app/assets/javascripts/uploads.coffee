$(document).on 'page:change', ->
  
  $('.redactor').redactor
    imageUploadParam:   'image'
    imageManagerJson:   '/uploads?type=image'
    fileManagerJson:    '/uploads?type=other'
    imageUpload:        '/uploads'
    clipboardUploadUrl: '/uploads'
    fileUpload:         '/uploads'
    lang: window.locale
    focus: true
    toolbarFixed: true
    plugins: ['imagemanager', 'filemanager']
    uploadImageFields:
      through: 'redactor'
      authenticity_token: $('meta[name="csrf-token"]').attr('content')
    uploadFileFields:
      through: 'redactor'
      authenticity_token: $('meta[name="csrf-token"]').attr('content')
