import { BaseController } from "./base_controller"

export default class extends BaseController {
  static targets = ["container", "input"]

  connect() {
    var context = this;

    var quill = new Quill(`#${$(context.containerTarget).attr('id')}`, {
      modules: {
        toolbar: [
          [{ header: [1, 2, 3, 4, 5, 6, false] }],
          [{ color: [] }],
          [{ size: [] }],
          [
            'bold', 'italic', 'underline', 'strike',
            { 'script': 'super'},
            { 'script': 'sub' },
            'code', 'link'
          ],
          ['blockquote', 'code-block'],
          [{ list: 'ordered' }, { list: 'bullet' }],
          [{ align: ['center', 'right', 'justify', false] }],
          [{ indent: '-1'}, { indent: '+1' }]
        ]
      },
      placeholder: 'Type your text here...',
      theme: 'snow'
    });

    quill.on('text-change', function(delta, oldDelta, source) {
      console.log(context.inputTarget);
      $(context.inputTarget).val(quill.root.innerHTML);
    });
  }
}
