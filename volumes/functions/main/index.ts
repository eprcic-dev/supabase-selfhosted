import { serve } from "https://deno.land/std@0.168.0/http/server.ts";

serve(async (req: Request) => {
  const url = new URL(req.url);
  const { pathname } = url;

  if (pathname === "/" || pathname === "") {
    return new Response(
      JSON.stringify({ message: "Supabase Edge Functions running" }),
      { headers: { "Content-Type": "application/json" } }
    );
  }

  return new Response(
    JSON.stringify({ error: "Function not found" }),
    { status: 404, headers: { "Content-Type": "application/json" } }
  );
});
