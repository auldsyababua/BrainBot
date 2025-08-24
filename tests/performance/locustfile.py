#!/usr/bin/env python3
"""
Locust Load Testing for Markdown Brain Bot

This file simulates real user behavior to test bot performance under load.
Designed for non-coders to understand and modify basic scenarios.

Usage:
    # Run with web UI (recommended)
    locust -f tests/locustfile.py --host http://localhost:8000

    # Run headless with 10 users
    locust -f tests/locustfile.py --host http://localhost:8000 --headless -u 10 -r 2

    # Run against production (be careful!)
    locust -f tests/locustfile.py --host https://your-bot-url.com
"""

import random
from datetime import datetime

from locust import HttpUser, between, task


class MarkdownBrainBotUser(HttpUser):
    """
    Simulates a typical user interacting with the markdown brain bot.

    wait_time: How long users wait between actions (2-8 seconds)
    This mimics real human behavior - people don't spam bots instantly.
    """

    wait_time = between(2, 8)

    def on_start(self):
        """Called when a user starts - set up their identity."""
        # Generate unique user ID for this simulated user
        self.user_id = f"load_test_user_{random.randint(1000, 9999)}"
        self.chat_id = f"chat_{self.user_id}_{datetime.now().timestamp()}"

        # Track notes this user has created for later searches
        self.created_notes = []

        # Common topics this user might be interested in
        self.topics = [
            "project deadline",
            "team meeting",
            "bug report",
            "feature request",
            "documentation",
            "todo list",
            "code review",
            "standup notes",
        ]

    def send_message(self, message: str, name: str = None):
        """Helper to send a message to the bot."""
        payload = {"message": message, "chat_id": self.chat_id, "user_id": self.user_id}

        # Use name parameter for better Locust reporting
        with self.client.post(
            "/webhook",  # Adjust this to your bot's endpoint
            json=payload,
            name=name or "send_message",
            catch_response=True,
        ) as response:
            if response.status_code == 200:
                response.success()
            else:
                response.failure(f"Got status code {response.status_code}")

    # =====================================
    # Basic User Scenarios (Tasks)
    # =====================================

    @task(3)
    def save_note(self):
        """User saves a new note - most common action."""
        topic = random.choice(self.topics)
        note_content = self._generate_note_content(topic)

        message = f"Save note: {note_content}"
        self.send_message(message, name="save_note")

        # Remember what we saved for later searches
        self.created_notes.append(
            {"topic": topic, "content": note_content, "timestamp": datetime.now()}
        )

    @task(2)
    def search_notes(self):
        """User searches for existing notes."""
        if self.created_notes:
            # Search for something we know exists
            note = random.choice(self.created_notes)
            search_term = note["topic"]
        else:
            # Search for random topic
            search_term = random.choice(self.topics)

        message = f"Search for {search_term}"
        self.send_message(message, name="search_notes")

    @task(1)
    def list_all_notes(self):
        """User lists all their notes."""
        message = "List all my notes"
        self.send_message(message, name="list_notes")

    @task(2)
    def ask_question(self):
        """User asks a general question."""
        questions = [
            "What notes do I have from yesterday?",
            "When is my next deadline?",
            "What did we discuss in the last meeting?",
            "Show me my todo items",
            "What bugs are still open?",
            "Summarize my project notes",
        ]

        message = random.choice(questions)
        self.send_message(message, name="ask_question")

    @task(1)
    def update_note(self):
        """User updates an existing note."""
        if not self.created_notes:
            # Create a note first if we don't have any
            self.save_note()
            return

        note = random.choice(self.created_notes)
        update = f"Add to {note['topic']} note: Updated at {datetime.now().strftime('%H:%M')}"
        self.send_message(update, name="update_note")

    @task(1)
    def complex_interaction(self):
        """User has a multi-step interaction."""
        # Save a note, then immediately search for it
        topic = "important deadline"
        note_content = f"{topic}: Project Alpha due on Friday at 5pm"

        # Step 1: Save
        self.send_message(f"Save note: {note_content}", name="complex_save")

        # Small delay to simulate reading response
        self._think_time()

        # Step 2: Search
        self.send_message(f"When is the {topic}?", name="complex_search")

    # =====================================
    # Helper Methods
    # =====================================

    def _generate_note_content(self, topic: str) -> str:
        """Generate realistic note content based on topic."""
        templates = {
            "project deadline": [
                f"{topic}: Project {random.choice(['Alpha', 'Beta', 'Gamma'])} due {random.choice(['Friday', 'Monday', 'next week'])}",
                f"{topic}: Complete phase {random.randint(1, 3)} by end of sprint",
            ],
            "team meeting": [
                f"{topic}: Standup at {random.choice(['9am', '10am', '2pm'])} in {random.choice(['Room A', 'Zoom', 'Teams'])}",
                f"{topic}: Discussed new features, assigned to {random.choice(['John', 'Sarah', 'Mike'])}",
            ],
            "bug report": [
                f"{topic}: Issue #{random.randint(100, 999)} - {random.choice(['Login fails', 'Search broken', 'UI glitch'])}",
                f"{topic}: Critical bug in {random.choice(['payment', 'auth', 'search'])} module",
            ],
            "feature request": [
                f"{topic}: Add {random.choice(['dark mode', 'export function', 'bulk operations'])}",
                f"{topic}: User requested {random.choice(['faster search', 'better UI', 'mobile app'])}",
            ],
            "documentation": [
                f"{topic}: Update {random.choice(['API docs', 'user guide', 'README'])}",
                f"{topic}: Document {random.choice(['deployment process', 'new features', 'architecture'])}",
            ],
            "todo list": [
                f"{topic}: 1. {random.choice(['Review PR', 'Fix bugs', 'Write tests'])} 2. {random.choice(['Deploy', 'Meeting', 'Documentation'])}",
                f"{topic}: Priority items for {random.choice(['today', 'this week', 'sprint'])}",
            ],
            "code review": [
                f"{topic}: PR #{random.randint(10, 99)} needs {random.choice(['approval', 'changes', 'testing'])}",
                f"{topic}: Reviewed {random.choice(['auth', 'search', 'UI'])} changes - {random.choice(['LGTM', 'needs work', 'approved'])}",
            ],
            "standup notes": [
                f"{topic}: Yesterday: {random.choice(['Fixed bugs', 'Wrote tests', 'Deployed'])}. Today: {random.choice(['New feature', 'Code review', 'Documentation'])}",
                f"{topic}: Blocked on {random.choice(['API access', 'design approval', 'dependencies'])}",
            ],
        }

        # Get templates for this topic, or use generic
        topic_templates = templates.get(
            topic, [f"{topic}: Generic note created at {datetime.now()}"]
        )
        return random.choice(topic_templates)

    def _think_time(self):
        """Simulate user reading/thinking time."""
        import time

        time.sleep(random.uniform(0.5, 2.0))


class PowerUser(MarkdownBrainBotUser):
    """
    A power user who interacts more frequently and does more complex operations.
    """

    wait_time = between(1, 3)  # Faster interactions

    @task(4)
    def bulk_operations(self):
        """Power user creates multiple notes at once."""
        num_notes = random.randint(3, 5)
        for i in range(num_notes):
            topic = random.choice(self.topics)
            note = self._generate_note_content(topic)
            self.send_message(f"Save note: {note}", name=f"bulk_save_{i+1}")
            self._think_time()  # Small delay between notes


class MobileUser(MarkdownBrainBotUser):
    """
    Simulates a mobile user with shorter messages and different patterns.
    """

    wait_time = between(5, 15)  # Slower, like typing on mobile

    @task(5)
    def quick_note(self):
        """Mobile users often create very short notes."""
        quick_notes = [
            "Buy milk",
            "Call John",
            "Meeting 3pm",
            "Check email",
            "Dentist Tuesday",
            "Project deadline!",
        ]

        message = f"Save note: {random.choice(quick_notes)}"
        self.send_message(message, name="mobile_quick_note")


# =====================================
# Load Test Configurations
# =====================================

"""
Predefined test scenarios for easy use:

1. BASIC TEST (Development)
   - Users: 5-10
   - Spawn rate: 1 user/second
   - Good for: Testing basic functionality
   - Command: locust -f tests/locustfile.py --host http://localhost:8000 --headless -u 10 -r 1

2. NORMAL LOAD (Staging)
   - Users: 50-100  
   - Spawn rate: 2 users/second
   - Good for: Testing typical daily load
   - Command: locust -f tests/locustfile.py --host http://localhost:8000 --headless -u 100 -r 2

3. PEAK LOAD (Stress Test)
   - Users: 200-500
   - Spawn rate: 5 users/second  
   - Good for: Finding breaking points
   - Command: locust -f tests/locustfile.py --host http://localhost:8000 --headless -u 500 -r 5

4. ENDURANCE TEST
   - Users: 50
   - Duration: 30+ minutes
   - Good for: Finding memory leaks
   - Command: locust -f tests/locustfile.py --host http://localhost:8000 --headless -u 50 -r 1 -t 30m


TIPS FOR NON-CODERS:

- Start with BASIC TEST to ensure everything works
- Watch for response times > 2 seconds (users will notice)
- If failure rate > 1%, something is wrong
- Memory usage should stay stable in endurance tests
- CPU usage > 80% means you need optimization or scaling
"""
