// // https://stackoverflow.com/questions/70548841/how-to-add-custom-js-file-to-new-rails-7-project

document.addEventListener('DOMContentLoaded', () => {
    console.log("Hoang")
    const burger = document.getElementsByClassName("navbar-burger")[0]
    const navbar_menu = document.getElementsByClassName("navbar-menu")[0]

    if (burger != null) {
        burger.addEventListener('click', function(e) {
            e.preventDefault()
            console.log("click")
            if (burger.classList.contains("is-active")) {
                burger.classList.remove("is-active")
                navbar_menu.classList.remove("is-active")
                console.log("Contain is-acitve")
            } else {
                burger.classList.add("is-active")
                navbar_menu.classList.add("is-active")
                console.log("not contain is-acitve")
            }
        }, false)
    }
})