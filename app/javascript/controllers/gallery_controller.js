import { Controller } from "@hotwired/stimulus"
import { Fancybox } from "@fancyapps/ui"

export default class extends Controller {
    static targets = ["modal", "galleryImage", "blogImage"]  // 타겟 정의 추가

    connect() {
        Fancybox.bind('[data-fancybox="gallery"]', {})

        // 각 이미지 그룹 독립적으로 처리
        this.loadGalleryImages()
        this.loadBlogImages()
    }


    disconnect() {
        // 컨트롤러가 해제될 때 Fancybox 인스턴스도 정리
        Fancybox.close()
        Fancybox.destroy()
    }

    // 갤러리 이미지 처리
    loadGalleryImages() {
        // galleryImageTargets가 존재하는 경우에만 처리
        if (this.hasGalleryImageTarget) {
            this.galleryImageTargets.forEach(img => {
                const originalSrc = img.getAttribute('data-original')
                if (originalSrc) {
                    img.src = originalSrc
                    img.removeAttribute('data-original')
                }
            })
        }
    }

    // 블로그 이미지 처리
    loadBlogImages() {
        // blogImageTargets가 존재하는 경우에만 처리
        if (this.hasBlogImageTarget) {
            this.blogImageTargets.forEach(img => {
                const originalSrc = img.getAttribute('data-original')
                if (originalSrc) {
                    img.src = originalSrc
                    img.removeAttribute('data-original')
                }
            })
        }
    }
}

