
import React, { useState, useEffect } from "react";
import { useParams } from "react-router-dom";
import Header from "./Header";
import Footer from "./Footer";

export default function DocumentPage() {
  const { id } = useParams();
  const [doc, setDoc] = useState(null);

  // Fetch document data
  useEffect(() => {
    fetch(`/api/documents/${id}`)
      .then((response) => response.json())
      .then((data) => setDoc(data))
      .catch((error) => {
        console.error("Error fetching document:", error);
      });
  }, [id]);

  // Add copy buttons after content renders
  useEffect(() => {
    if (!doc) return;

    const pres = document.querySelectorAll("pre");
    pres.forEach((pre) => {
      // Avoid adding duplicate buttons
      if (pre.querySelector(".copy-btn")) return;

      const button = document.createElement("button");
      button.className = "copy-btn";
      button.textContent = "Copy";
      button.addEventListener("click", () => {
        navigator.clipboard.writeText(pre.textContent.trim());
        button.textContent = "Copied!";
        setTimeout(() => (button.textContent = "Copy"), 1000);
      });
      pre.insertBefore(button, pre.firstChild);
    });
  }, [doc]);

  if (!doc) {
    return (
      <>
        <Header />
        <main><p>Loading...</p></main>
        <Footer />
      </>
    );
  }

  return (
    <>
      <Header title={doc.title} />
      <main>
        <h2>{doc.title}</h2>
        <div
          className="content"
          dangerouslySetInnerHTML={{ __html: doc.content }}
        />
      </main>
      <Footer />
    </>
  );
}

