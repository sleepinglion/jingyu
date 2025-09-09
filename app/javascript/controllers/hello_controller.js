// app/javascript/controllers/tag_canvas_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["canvas", "tags"]

    connect() {
        if (this.hasCanvasTarget) {
            TagCanvas.Start(this.canvasTarget.id, this.tagsTarget.id, {
                outlineThickness: 1,
                maxSpeed: 0.05,
                textFont: null,
                textColour: null,
                weight: true,
                depth: 1
            })
        } else {
            this.handleFailure()
        }
    }

    handleFailure() {
        const container = this.element.querySelector('#myCanvasContainer')
        if (container) {
            container.style.display = 'none'
        }

        const tagsList = this.tagsTarget.querySelector('ul')
        if (tagsList) {
            Object.assign(tagsList.style, {
                margin: '0',
                padding: '0',
                listStyle: 'none'
            })

            tagsList.querySelectorAll('li').forEach(li => {
                Object.assign(li.style, {
                    float: 'left',
                    margin: '0 10px'
                })
            })
        }
    }
}
