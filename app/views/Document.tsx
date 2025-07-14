import React, { useState, useEffect } from "react";
import { useParams } from "react-router-dom";
import Header from "./Header";
import Footer from "./Footer";

export default function Document() {
  const { id } = useParams(); // 🔹 Get the `id` from the URL
  const [document, setDocument] = useState(null);

  useEffect(() => {
    fetch(`/api/documents/${id}`)
      .then(response => response.json())
      .then(data => setDocument(data))
      .catch(error => {
        console.error("Error fetching document:", error);
      });
  }, [id]); // 🔹 re-fetch if id changes

  if (!document) {
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
        <h2>{document.title}</h2>
        <div dangerouslySetInnerHTML={{ __html: document.content }} />
      </main>
      <Footer />
    </>
  );
}

