const items = [...document.querySelectorAll(".gallery-item")];
const modal = document.querySelector("#imageModal");
const modalImage = modal.querySelector("img");
const modalTitle = modal.querySelector("strong");
const modalDetail = modal.querySelector("span");
const closeButton = modal.querySelector(".modal-close");
const nextButton = modal.querySelector(".modal-next");
const prevButton = modal.querySelector(".modal-prev");
const heroButtons = [...document.querySelectorAll(".hero-strip button")];
let activeIndex = 0;

function openModal(index) {
  activeIndex = index;
  const item = items[activeIndex];
  const image = item.querySelector("img");

  modalImage.src = image.src;
  modalImage.alt = image.alt;
  modalTitle.textContent = item.dataset.title;
  modalDetail.textContent = item.dataset.detail;
  modal.setAttribute("aria-hidden", "false");
  document.body.classList.add("modal-open");
  closeButton.focus();
}

function closeModal() {
  modal.setAttribute("aria-hidden", "true");
  document.body.classList.remove("modal-open");
  items[activeIndex].querySelector("button").focus();
}

function moveModal(direction) {
  activeIndex = (activeIndex + direction + items.length) % items.length;
  openModal(activeIndex);
}

items.forEach((item, index) => {
  item.querySelector("button").addEventListener("click", () => openModal(index));
  item.addEventListener("dblclick", () => openModal(index));
});

heroButtons.forEach((button) => {
  button.addEventListener("click", () => openModal(Number(button.dataset.jump)));
});

closeButton.addEventListener("click", closeModal);
nextButton.addEventListener("click", () => moveModal(1));
prevButton.addEventListener("click", () => moveModal(-1));

modal.addEventListener("click", (event) => {
  if (event.target === modal) {
    closeModal();
  }
});

document.addEventListener("keydown", (event) => {
  if (modal.getAttribute("aria-hidden") === "true") {
    return;
  }

  if (event.key === "Escape") {
    closeModal();
  }

  if (event.key === "ArrowRight") {
    moveModal(1);
  }

  if (event.key === "ArrowLeft") {
    moveModal(-1);
  }
});
