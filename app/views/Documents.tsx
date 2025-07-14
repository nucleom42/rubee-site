import React, { useState, useEffect } from "react";
import { useParams, Link } from "react-router-dom";
import Header from "./Header";
import Footer from "./Footer";

export default function Documents() {
  const { id } = useParams();
  const [documents, setDocuments] = useState(null);

  useEffect(() => {
    fetch(`/api/sections/${id}/documents`)
      .then(response => response.json())
      .then(data => setDocuments(data))
      .catch(error => {
        console.error("Error fetching document:", error);
      });
  }, [id, setDocuments]); // 🔹 re-fetch if id changes

  if (!documents) {
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
        <div className="features">
        {documents.map(doc => (
            <div key={doc.id} className="feature">
            <Link to={`/documents/${doc.id}`}>
                <h3>{doc.title}</h3>
                <p dangerouslySetInnerHTML={{ __html: doc.content }} />
            </Link>
            </div>
          ))}
        </div>
      </main>
      <Footer />
    </>
  );
}

