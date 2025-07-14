
import React, { useState, useEffect } from "react";
import { useParams } from "react-router-dom";
import Header from "./Header";
import Footer from "./Footer";

export default function DocumentPage() {
  const { id } = useParams();
  const [docData, setDocData] = useState(null);

  // Fetch document data
  useEffect(() => {
    fetch(`/api/documents/${id}`)
      .then((response) => response.json())
      .then((data) => setDocData(data))
      .catch((error) => {
        console.error("Error fetching document:", error);
      });
  }, [id]);

  // Add copy buttons after content renders
  useEffect(() => {
    if (!docData) return;

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
  }, [docData]);

  if (!docData) {
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
      <Header />
      <main>
        <h2>{docData.title}</h2>
        <div
          className="content"
          dangerouslySetInnerHTML={{ __html: docData.content }}
        />
      </main>
      <Footer />
    </>
  );
}

