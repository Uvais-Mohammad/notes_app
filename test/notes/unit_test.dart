import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notes_app/features/notes/index.dart';

/// A testing utility which creates a [ProviderContainer] and automatically
/// disposes it at the end of the test.
ProviderContainer createContainer({
  ProviderContainer? parent,
  List<Override> overrides = const [],
  List<ProviderObserver>? observers,
}) {
  // Create a ProviderContainer, and optionally allow specifying parameters.
  final container = ProviderContainer(
    parent: parent,
    overrides: overrides,
    observers: observers,
  );

  // When the test ends, dispose the container.
  addTearDown(container.dispose);

  return container;
}

void main() {
  group('Providers', () {
    test('Test addNoteColorProvider initial value is red', () {
      final container = createContainer();

      expect(
        container.read(addNoteColorProvider),
        equals(Colors.red),
      );
    });

    test('Test addNoteColorProvider value is blue after update', () {
      final container = createContainer();
      container.read(addNoteColorProvider.notifier).changeColor(Colors.blue);
      expect(
        container.read(addNoteColorProvider),
        equals(Colors.blue),
      );
    });
  });

  test('Test selectNoteProvider initial value is null', () {
    final container = createContainer();

    expect(
      container.read(selectNoteProvider),
      equals(null),
    );
  });

  test('Test selectNoteProvider value is note after update', () {
    final container = createContainer();
    final note = Note(
      id: 1,
      title: 'title',
      content: 'description',
      color: Colors.red,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    container.read(selectNoteProvider.notifier).select(note);
    expect(
      container.read(selectNoteProvider),
      equals(note),
    );
  });

  test('Test notesProvider initial state is loading', () {
    final container = createContainer();
    expect(
      container.read(notesProvider),
      equals(const AsyncValue<List<Note>>.loading()),
    );
  });

  
}
