function answer() {
  const submit = document.getElementById("submit-answer");
  submit.addEventListener("click", (e) => {
    const formData = new FormData(document.getElementById("form-answer"));
    const XHR = new XMLHttpRequest();
    XHR.open("POST", "/messages", true);
    XHR.responseType = "json";
    XHR.send(formData);
    XHR.onload = () => {
      if (XHR.status != 200) {
        alert(`Error ${XHR.status}: ${XHR.statusText}`);
        return null;
      } else if (XHR.response.message != null) {
        const message = XHR.response.message;
        const user = XHR.response.user;
        const list = document.getElementById("list-answer");
        const formText = document.getElementById("content-answer");
        const HTML = `
                <li>[回答文][${user.nickname}]${message}</li>
          `;
        list.insertAdjacentHTML("afterend", HTML);
        formText.value = "";
        if (document.getElementById("errors") != null) {
          const errors = document.getElementById("errors");
          errors.remove()
        }
      } else {
        const HTML = `
          <div id='errors'>${XHR.response.content_error}</div>
          `;
        const error = document.getElementById("error-answer");
        if (document.getElementById("errors") != null) {
          const errors = document.getElementById("errors");
          errors.remove()
        }
        error.insertAdjacentHTML("afterend", HTML);
      }
    };
    e.preventDefault();
  });
}
window.addEventListener("load", answer);