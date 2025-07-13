
import React, { useState, useEffect } from "react";
import Header from "./Header";
import Footer from "./Footer";

export default function Document() {
  const [document, setDocument] = useState(null);

  useEffect(() => {
    fetch(`/api/documents/2`)
      .then(response => response.json())
      .then(data => setDocument(data))
      .catch(error => {
        console.error("Error fetching document:", error);
      });
  }, []);

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

